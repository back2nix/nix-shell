{ pkgs ? import <nixpkgs> { } }:
let
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    dontStrip = true;
    cmakeBuildType = "Debug"; # if your wants debug build
    enableCudnn = false;

    # sourceRoot = ".";

    # dontUnpack = true;
    # dontPatch = true;
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

      ## -- for get prebuild + source folders
      ## -- commented this after save prebuild folder in local machine
      mkdir -p $out/build
      cp -r * $out/build
      false
    '';

    preInstall = ''
    '';

    # src = ./debug/source; # and set, dontPatch = true;
    src = builtins.fetchGit {
      shallow = true;
      url = ./debug/source; # without prebuild, only source
    };
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
