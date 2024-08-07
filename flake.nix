{
  outputs = {
    self,
    nixpkgs,
  }: {
    packages.x86_64-linux.miredo = ./flake_miredo;
    # или
    # packages.x86_64-linux.default = ...;
  };
}
