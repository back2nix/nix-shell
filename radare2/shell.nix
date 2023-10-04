{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  name = "r2-shell";

  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
    radare2
  ];

  hardeningDisable = ["all"];
}
