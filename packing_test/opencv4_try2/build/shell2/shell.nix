{ pkgs ? import <nixpkgs> { } }:
let
  # opencv = pkgs.callPackage ./package.nix { };
in
with pkgs;
pkgs.mkShell
{
  name = "opencv4-shell";

  # nativeBuildInputs
  buildInputs = with pkgs; [
    which
    cmake
    git
    openssh
    # opencv
    stdenv
  ];

  shellHook = ''
    export CMAKE_PREFIX_PATH="/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2/build/opencv/build/install_dir";
  '';
  # export CMAKE_PREFIX_PATH="${opencv}";
  # echo $CMAKE_PREFIX_PATH;
  # echo installDir=${installDir}
}
