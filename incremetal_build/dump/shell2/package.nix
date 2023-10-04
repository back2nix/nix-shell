{ stdenv
, lib
,
}:
stdenv.mkDerivation rec {
  pname = "opencv";
  version = "4.7.0";

  shallow = true;
  src = ../opencv/build;
  # builtins.fetchGit
  #   {
  #     url = "/home/bg/Documents/code/github.com/back2nix/nix/nix-shell/packing_test/opencv4_try2/build/opencv";
  #     shallow = true;
  #   };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out
    cp -R build/install_dir/* $out/
    echo $out:
  '';

  meta = with lib; {
    description = "home made opencv for debug";
  };
}
