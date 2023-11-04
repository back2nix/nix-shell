{pkgs ? import <nixpkgs> {}}: let
  refind = pkgs.callPackage ./refind {};
in
  with pkgs;
    pkgs.mkShell
    {
      name = "refind-shell";

      # nativeBuildInputs
      buildInputs = with pkgs; [
        refind
      ];

      shellHook = ''
      '';
    }
