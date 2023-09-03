{
  lib,
  buildPythonPackage,
  fetchurl,
  # fetchFromGitLab,
  # python310Packages,
  pythonOlder,
  pytestCheckHook,
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
  pname = "simple-knn";
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

    src = fetchurl {
      url = "https://gitlab.inria.fr/bkerbl/simple-knn/-/archive/main/simple-knn-main.zip";
      sha256 = "sha256-fb81z5jGnY97Rqk996e56r71mChnVhBSMJV/H23aKIA=";
    };

    # src = fetchFromGitLab {
    #   owner = "bkerbl";
    #   repo = "simple-knn";
    #   rev = "44f764299fa305faf6ec5ebd99939e0508331503";
    #   sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    # };

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

    nativeCheckInputs = [pytestCheckHook];

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
      # torch
    ];

    doCheck = false; # tests require CUDA and also GPU access

    pythonImportsCheck = [
    ];

    # shellHook = ''
    #   echo "You are now using a NIX environment"
    # '';

    meta = with lib; {
      homepage = "https://gitlab.inria.fr/bkerbl/simple-knn.git";
      description = "";
      # license = licenses.???;
      # maintainers = with maintainers; [???];
    };
  }
