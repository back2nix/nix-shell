let
  pkgs = import <nixpkgs> {};
  opencv = pkgs.callPackage ./package.nix {};
in
  # {
  #   build = pkgs.callPackage ./package.nix { };
  # }
  {
    inherit opencv;
    shell = pkgs.mkShell {
      buildInputs = with pkgs; [
        cmake
        stdenv
      ];
      inputsFrom = [
        opencv
      ];

      # shellHook = ''
      #   export PKG_CONFIG_PATH=/nix/store/jjidz19djd25jl1ys2mrfwnwc3xnwlxj-opencv-4.7.0/lib/pkgconfig
      # '';
      # packages = with pkgs.python3Packages; [
      #   black
      #   flake8
      # ];
    };
  }
