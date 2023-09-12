# { pkgs ? (
#     let
#       sources = import ./nix/sources.nix;
#     in
#     import sources.nixpkgs {
#       config = {
#         allowUnfree = true;
#         cudaSupport = true;
#       };
#     }
#   )
# , # , cachnix ? import <nixpkgs> { }
# }:
{
  pkgs ?
    import <nixpkgs> {
      config = {
        allowUnfree = true;
        cudaSupport = true;
      };
    },
}: let
  # diff-gaussian-rasterization = pkgs.python3Packages.callPackage ./third-party/diff-gaussian-rasterization/default.nix { };
  # simple-knn = pkgs.python3Packages.callPackage ./third-party/diff-gaussian-rasterization/default.nix { };
  stdenvGCC11 = pkgs.overrideCC pkgs.stdenv pkgs.gcc11;
  cudatoolkit = pkgs.cudaPackages_11_7.cudatoolkit.override {
    stdenv = stdenvGCC11;
  };
in
  pkgs.mkShell.override
  {
    stdenv = pkgs.gcc11Stdenv;
  }
  # pkgs.mkShell
  {
    name = "diff-gaussian-shell";
    # https://www.youtube.com/watch?v=A1Gbycj0bWw&ab_channel=TheNeRFGuru

    buildInputs = with pkgs.python310Packages; [
      # pkgs.gcc11
      # pkgs.gcc11
      # pkgs.gcc11Stdenv.glibc

      pkgs.python310
      pkgs.glm
      cudatoolkit
      # diff-gaussian-rasterization
      # simple-knn
      fastai
      fastdownload
      pytorch-bin
      unidecode
      # torchaudio
      # inflect
      # cachnix.python310Packages.accelerate
      librosa
      pip
      pandas
      pillow
      scipy
      requests
      scikit-learn
      matplotlib
      pyyaml
      accelerate
      ipywidgets
      plyfile
      tqdm
      venvShellHook
    ];
    venvDir = "venv310";

    doCheck = false;

    postShellHook = ''
      pip install submodules/diff-gaussian-rasterization
      pip install submodules/simple-knn

      echo "You are now using a NIX environment"
      export CUDA_PATH=${cudatoolkit}
    '';

    # shellHook = ''
    #   pip install submodules\diff-gaussian-rasterization
    #   pip install submodules\simple-knn
    #
    #   echo "You are now using a NIX environment"
    #   export CUDA_PATH=${pkgs.cudatoolkit}
    # '';

    # env = {
    #   CUDA_PATH = ${pkgs.cudatoolkit};
    # };
  }
