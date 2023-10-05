{ pkgs ? import <nixpkgs> { } }:
let
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    separateDebugInfo = true;
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

    # bock
    postConfigure = '''';

    # block docs
    postBuild = '''';

    # block test
    preInstall = ''
    '';

    src = ./debug/source; # second run, set: dontPatch = true;
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
