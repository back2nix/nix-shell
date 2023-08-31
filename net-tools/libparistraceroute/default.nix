let
  pkgs = import <nixpkgs> { };
in
{
  libparistraceroute = pkgs.callPackage ./libparistraceroute.nix { };
}
