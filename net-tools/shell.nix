{ pkgs ? import (<nixpkgs>) { } }:

pkgs.mkShell {
  name = "net-tools";

  nativeBuildInputs = with pkgs; [
    traceroute
    inetutils
    mtr
  ];

  hardeningDisable = [ "all" ];
}
