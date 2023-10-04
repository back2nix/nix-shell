{ pkgs ? import <nixpkgs> { } }:
let
  opencv4WithDebug = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    # separateDebugInfo = true;
    # dontStrip = true;
    # cmakeBuildType = "Debug";
    # dontUnpack = true;
    # phases = "unpackPhase";

    # sourceRoot = ".";
    # setSourceRoot = "/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2";

    # NIX_BUILD_TOP = "/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2";

    # prePhases = ''
    #   export NIX_BUILD_TOP=/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2
    #   export TMPDIR=/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2
    # '';

    # dontUnpack = true;
    dontPatch = true;
    # dontConfigure = true;

    # postUnpack =
    #   old.postUnpack
    #   + ''
    #     # set -x
    #     # set +e
    #     # export NIX_ENFORCE_PURITY=0
    #     # false
    #
    #     # echo out=$out
    #     # echo src=$out
    #     # echo contribSrc=${old.postUnpack}
    #     # echo NIX_BUILD_TOP/source:
    #     # ls $NIX_BUILD_TOP/source
    #     # cp -r $NIX_BUILD_TOP/source /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2/
    #
    #   '';

    # unpackPhaseExport = ''
    #   mkdir $out
    #   cp -r "/build/$sourceRoot" $out
    #   echo "sourceRoot=$sourceRoot" >$out/sourceRoot.env.sh
    # '';

    # preConfigure =
    #   old.preConfigure
    #   + ''
    #     false
    #   '';

    preBuild = ''
      # echo "ls ."
      #   ls .
      # echo "ls .."
      #   ls ..
      # echo "ls ../.."
      #   ls ../..
        # mkdir -p $out/save
        # cp -r ../../source $out/save
        false
    '';
    # export NIX_ENFORCE_PURITY=0 - not work

    # dontBuild = true;
    # setSourceRoot = "/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/opencv/source";
    # sourceRoot = "/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/opencv/srcRoot";
    # git clone --branch 4.7.0 https://github.com/opencv/opencv.git
    # git clone --branch 4.7.0 https://github.com/opencv/opencv_contrib.git
    # git clone --branch 4.7.0 https://github.com/opencv/opencv_extra.git

    src = builtins.fetchGit /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv;
    # src = /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv;
    # contribSrc = builtins.fetchGit /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv_contrib;
    # testDataSrc = builtins.fetchGit /home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv/source/opencv_extra;
  });
  # hello = pkgs.callPackage ./hello.nix { };
in
pkgs.mkShell
{
  name = "opencv4-shell";

  # nativeBuildInputs is usually what you want -- tools you need to run
  # nativeBuildInputs = with pkgs; [
  #   # hello
  #   stdenv
  #   # opencv4WithDebug
  #   gdb
  #   cmake
  # ];

  nativeBuildInputs = with pkgs; [
    opencv4WithDebug
  ];

  # shellHook = ''
  # touch file
  # echo sourceRoot=$sourceRoot
  # runHook unpackPhase
  # echo sourceRoot=$sourceRoot
  # cd $sourceRoot
  # runHook patchPhase
  # '';

  # hardeningDisable = [ "all" ];
}
