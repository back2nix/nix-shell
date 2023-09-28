{ pkgs ? import <nixpkgs> { } }:
pkgs.mkShell {
  name = "ffmpeg-shell";

  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
    ffmpeg
  ];

  hardeningDisable = [ "all" ];
}
