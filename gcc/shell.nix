with import <nixpkgs> {}; let
masterPkg = (import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/master.tar.gz") {
    nixpkgs.config = {
      allowUnfree = true;
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "google-chrome"                                        
        ];                                                       
      };
    });

in
  pkgs.mkShell
  rec {
    name = "gcc-env";
    buildInputs = with pythonPackages; [
      # python
      # pip
      #
      # venvShellHook

      # PyExecJS

      # numpy
      # requests
      # flask
      # flask-babel
      # browser-cookie3
      # aiohttp
      # pycrypto
      # taglib
      # libxml2
      # libxslt
      openssl
      git
      libzip
      zlib
      pkgs.stdenv.cc.cc.lib
      gcc13
      masterPkg.lunarvim
    ];

    # venvDir = "venv310";

    LD_LIBRARY_PATH = "${pkgs.stdenv.cc.cc.lib}/lib/";

# pip install -r requirements.txt
    postShellHook = ''
    '';
  }
