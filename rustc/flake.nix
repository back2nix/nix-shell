{
  description = "A devShell example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    # rust-nipkgs.url = "github:nixos/nixpkgs/2030abed5863fc11eccac0735f27a0828376c84e";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , rust-overlay
    , flake-utils
    , ...
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in
      with pkgs; {
        devShells.default = mkShell {
          nativeBuildInputs = [
            openssl
            pkg-config
            udev
            alsa-lib
            eza
            fd
            rust-bin.beta.latest.default
            # inputs.rust-nipkgs.${system}.rustc
          ];

          shellHook = ''
            alias ls=eza
            alias find=fd
            export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${
              with pkgs;
              lib.makeLibraryPath [
                  libGL 
                  xorg.libX11 
                  xorg.libXi
                  xorg.libXcursor
                  xorg.libXrandr
              ]
            }"
          '';
        };
      }
      # system: let
      #   pkgs = nixpkgs.legacyPackages.${system};
      # in {
      #   devShells.default = import ./shell.nix {inherit pkgs;};
      # }
    );
}
