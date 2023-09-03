{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  # python310Packages,
  pythonOlder,
  setuptools,
  wheel,
  torchWithCuda,
  pybind11,
  glm,
  symlinkJoin,
  ninja,
  which,
  pythonRelaxDepsHook,
  autoPatchelfHook,
}: let
  pname = "diff-gaussian-rasterization";
  version = "0.0.0";

  inherit (torchWithCuda) cudaCapabilities cudaPackages cudaSupport;
  inherit (cudaPackages) backendStdenv cudaVersion;

  # NOTE: torchvision doesn't use cudnn; torch does!
  #   For this reason it is not included.
  cuda-common-redist = with cudaPackages; [
    cuda_cccl # <thrust/*>
    libcublas # cublas_v2.h
    libcurand
    libcusolver # cusolverDn.h
    libcusparse # cusparse.h
  ];

  cuda-native-redist = symlinkJoin {
    name = "cuda-native-redist-${cudaVersion}";
    paths = with cudaPackages;
      [
        cuda_cudart # cuda_runtime.h cuda_runtime_api.h
        cuda_nvcc
      ]
      ++ cuda-common-redist;
  };

  cuda-redist = symlinkJoin {
    name = "cuda-redist-${cudaVersion}";
    paths = cuda-common-redist;
  };
in
  buildPythonPackage {
    inherit pname version;
    format = "pyproject";

    disabled = pythonOlder "3.7";

    src = fetchFromGitHub {
      owner = "graphdeco-inria";
      repo = "diff-gaussian-rasterization";
      rev = "59f5f77e3ddbac3ed9db93ec2cfe99ed6c5d121d";
      sha256 = "sha256-SKSSpEa9ydi4+aLPO4cD/N/nYnM9Gd5Wz4nNNvBKb58=";
    };

    preBuild = ''
      export MAX_JOBS=$NIX_BUILD_CORES;
    '';

    nativeBuildInputs =
      [
        setuptools
        wheel
        ninja
        which
        pythonRelaxDepsHook # torch and triton refer to each other so this hook is included to mitigate that.
        autoPatchelfHook
        torchWithCuda
      ]
      ++ lib.optionals torchWithCuda.cudaSupport [cuda-native-redist];
    buildInputs =
      [
        pybind11
        glm
      ]
      ++ lib.optionals torchWithCuda.cudaSupport [cuda-redist];

    preConfigure =
      ''
      ''
      + lib.optionalString cudaSupport ''
        export CC=${backendStdenv.cc}/bin/cc
        export CXX=${backendStdenv.cc}/bin/c++
        export TORCH_CUDA_ARCH_LIST="${lib.concatStringsSep ";" cudaCapabilities}"
        export FORCE_CUDA=1
      '';

    propagatedBuildInputs = [
    ];

    doCheck = false; # tests require CUDA and also GPU access

    # pythonImportsCheck = [
    #   "diff-gaussian-rasterization"
    # ];

    # shellHook = ''
    #   echo "You are now using a NIX environment"
    # '';

    meta = with lib; {
      homepage = "https://github.com/graphdeco-inria/gaussian-splatting";
      description = "3D Gaussian Splatting for Real-Time Radiance Field Rendering";
      # license = licenses.???;
      # maintainers = with maintainers; [???];
    };
  }
