self: super: {
  go_1_21 = self.darwin.apple_sdk_11_0.callPackage ./go/1.21.nix {
    inherit (self.darwin.apple_sdk_11_0.frameworks) Foundation Security;
  };

  buildGo121Module = self.darwin.apple_sdk_11_0.callPackage ../go/module.nix {
    go = self.darwin.apple_sdk_11_0.callPackage ./go/1.21.nix {
      inherit (self.darwin.apple_sdk_11_0.frameworks) Foundation Security;
    };
  };
  buildGo121Package = self.darwin.apple_sdk_11_0.callPackage ../go/package.nix {
    go = self.darwin.apple_sdk_11_0.callPackage ./go/1.21.nix {
      inherit (self.darwin.apple_sdk_11_0.frameworks) Foundation Security;
    };
  };

  go = self.darwin.apple_sdk_11_0.callPackage ./go/1.21.nix {
    inherit (self.darwin.apple_sdk_11_0.frameworks) Foundation Security buildGo121Package;
  };
}
