{pkgs ? import <nixpkgs> {}}: let
in {
  opencv = pkgs.python310Packages.opencv4.overrideAttrs (finalAttrs: old: {
    dontStrip = true;
    cmakeBuildType = "Debug"; # if your wants debug build

    # dontUnpack = true;
    # dontPatch = true;
    # dontBuild = true;
    # dontConfigure = true;
    # dontInstall = true;
    doChek = false;

    outputs = [
      "out"
    ];

    postConfigure =
      old.postConfigure
      + ''
        cp -r ../../source $out
        mv $out/build $out/build_bk
        echo Path out:
        echo $out
      '';

    preInstall = ''
    '';

    postInstall =
      old.postInstall
      + ''
        # make -j$(nproc)
        echo Pre Build Path:
        echo $out

        mkdir -p $out/build
        cp -r * $out/build
        false
      '';

    # src = ./debug/source; # second run, set: dontPatch = true;

    # first run so the stalemate can apply
    src = builtins.fetchGit {
      shallow = true;
      url = ./stage1/source; # without prebuild, only source
    };
  });
}
