{pkgs ? import <nixpkgs> {}}: let
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    dontStrip = true;
    cmakeBuildType = "Debug"; # if your wants debug build

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

      ## -- for get prebuild + source folders
      mkdir -p $out/build
      cp -r * $out/build
      false
    '';

    preInstall = ''
    '';

    src = ./debug/source;
    # src = builtins.fetchGit /home/bg/debug/source; # without prebuild, only source
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
