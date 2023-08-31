{ pkgs ? import (<nixpkgs>) { } }:

pkgs.mkShell {
  name = "wine";

# nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
# support both 32- and 64-bit applications
# wineWowPackages.stable
# support 32-bit only
# wine
    (wine.override { wineBuild = "wine64"; })
# wine-staging (version with experimental features)
      wineWowPackages.staging
# winetricks (all versions)
      winetricks
# native wayland support (unstable)
# wineWowPackages.waylandFull
  ];

  hardeningDisable = [ "all" ];
}
