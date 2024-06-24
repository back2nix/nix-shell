{pkgs ? import <nixpkgs> {}}:

pkgs.mkShell {
  name = "go-shell";

  # nativeBuildInputs is usually what you want -- tools you need to run
  nativeBuildInputs = with pkgs; [
    # nixpkgs-fmt
    # rnix-lsp
    # docker-client
    # docker-compose
    # gnumake

    # go development
    # go_1_20
    # go-outline
    # gopls
    # gopkgs
    # go-tools
    # delve

    nodejs
    yarn
    # yarn2nix
    # nodejs_21
  ];

  permittedInsecurePackages = [
    "nix-2.15.3"
  ];

  hardeningDisable = ["all"];
}
