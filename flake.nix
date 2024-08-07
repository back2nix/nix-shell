{
  inputs.miredo-flake = {
    url = "github:back2nix/nix-shell?dir=flake_miredo";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    miredo-flake,
  }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      # ...
      modules = [
        miredo-flake.nixosModules.default
        # Другие модули...
      ];
    };
  };
}
