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
      ## -- required only on the first stage, then you need to comment
      mkdir -p $out/build
      cp -r * $out/build
      false
    '';

    preInstall = ''
    '';

    # src = ./debug/source; # second run, set: dontPatch = true;

    # first run so the stalemate can apply
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
