# { sources ? import ./nix/sources.nix
#   , pkgs ? import sources.nixpkgs {
#     config = {
#       allowUnfree = true;
#       cudaSupport = true;
#     };
#   }
# }:
{ pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  }
,
}:
# lib.debug.traceIf true "hello";
# let pkgs2 = import <nixpkgs> {};
# in pkgs.lib.debug.traceVal pkgs.cudaPackages.backendStdenv.cc
pkgs.mkShell {
  buildInputs = with pkgs.python310Packages; [
    pkgs.python310
    pkgs.cudaPackages.cudatoolkit
    fastai
    fastdownload
    pytorch-bin
    # torchaudio
    unidecode
    # inflect
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
    # nbdev
    # (import <nixpkgs> {
    #  config = {
    #  allowUnfree = true;
    #  cudaSupport = true;
    #  };
    #  }).python310Packages.accelerate
    # pkgs.python310.pkgs.accelerate
    # python310Packages.accelerate
    # accelerate
    # spacy
  ];

  doCheck = false;

  shellHook = ''
    echo "You are now using a NIX environment"
    export CUDA_PATH=${pkgs.cudatoolkit}
  '';

  # env = {
  #   CUDA_PATH = ${pkgs.cudatoolkit};
  # };
}
