{pkgs ? import <nixpkgs> {}}: let
  refind = pkgs.callPackage ./refind {};
in
  with pkgs;
    pkgs.mkShell
    {
      name = "refind-shell";

      buildInputs = with pkgs; [
        efibootmgr
        refind
      ];

      shellHook = ''
      '';
    }
