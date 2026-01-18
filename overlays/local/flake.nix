{
  description = "Local custom packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays.default = final: prev: {
        lib = prev.lib // {
          local = {
            buildFirefoxXpiAddon = final.callPackage ./lib/build-firefox-xpi-addon.nix {};
          };
        };
        
        local = (import ./pkgs { pkgs = final; }) // {
          firefoxAddons = import ./pkgs/addons { 
            pkgs = final;
            buildFirefoxXpiAddon = final.lib.local.buildFirefoxXpiAddon;
          };
        };
      };

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ self.overlays.default ];
          };
        in
        pkgs.local
      );
    };
}
