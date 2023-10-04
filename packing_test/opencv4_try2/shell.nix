{ pkgs ? import <nixpkgs> { } }:
let
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    # dontStrip = true;
    # cmakeBuildType = "Debug"; # if your wants debug build

    # sourceRoot = ".";

    # dontUnpack = true;
    dontPatch = true;
    # dontBuild = true;
    # dontConfigure = true;
    # dontInstall = true;
    doChek = false;

    outputs = [
      "out"
    ];

    buildPhase = ''
      make -j$(nproc)

      echo Path:
      echo $out

      # for get prebuild + source folders
      # mkdir -p $out/build
      # cp -r * $out/build
      # false
    '';

    preInstall = ''
    '';

    # git clone --branch 4.7.0 https://github.com/opencv/opencv.git
    # git clone --branch 4.7.0 https://github.com/opencv/opencv_contrib.git
    # git clone --branch 4.7.0 https://github.com/opencv/opencv_extra.git

    src = /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2/release/source;
    # src = builtins.fetchGit /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv;
    # contribSrc = builtins.fetchGit /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv_contrib;
    # testDataSrc = builtins.fetchGit /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv_extra;
  });
in
pkgs.mkShell
{
  name = "custom-opencv4-shell";

  buildInputs = with pkgs; [
    stdenv
    gdb
    cmake
    opencv
  ];
}
