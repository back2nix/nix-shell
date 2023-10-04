{ pkgs ? import <nixpkgs> { } }:
let
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    dontStrip = true;
    cmakeBuildType = "Debug"; # if your wants debug build

    # dontUnpack = true;
    dontPatch = true;
    # dontConfigure = true;
    # dontBuild = true;
    # dontInstall = true;
    doChek = false;

    outputs = [
      "out"
    ];

    buildPhase = ''
      make -j$(nproc)
    '';

    preInstall = ''
    '';

    src = ./debug2/source; # second run, set: dontPatch = true;
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
