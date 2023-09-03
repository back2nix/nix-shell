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
{ pkgs ? import <nixpkgs> {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  }
,
}:
let
  diff-gaussian-rasterization = pkgs.python3Packages.callPackage ./third-party/diff-gaussian-rasterization/default.nix { };
  simple-knn = pkgs.python3Packages.callPackage ./third-party/diff-gaussian-rasterization/default.nix { };
in
pkgs.mkShell
{
  name = "diff-gaussian-shell";
  # https://www.youtube.com/watch?v=A1Gbycj0bWw&ab_channel=TheNeRFGuru

  buildInputs = with pkgs.python310Packages; [
    pkgs.python310
    pkgs.cudaPackages.cudatoolkit
    diff-gaussian-rasterization
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
    diff-gaussian-rasterization
    simple-knn
    venvShellHook
  ];
  venvDir = "venv310";

  doCheck = false;

  shellHook = ''
    echo "You are now using a NIX environment"
    export CUDA_PATH=${pkgs.cudatoolkit}
  '';

  # env = {
  #   CUDA_PATH = ${pkgs.cudatoolkit};
  # };
}
