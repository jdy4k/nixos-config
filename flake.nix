{
  description = "jdy4k's nixOs configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts = {
      url = "github:Lyndeno/apple-fonts.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-25.11";
    };
    potatofox = {
      url = "git+https://codeberg.org/da157/PotatoFox";
      flake = false;
    };
    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      username = "mg";
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        lenovo-blue = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/lenovo-blue)
          ];
          specialArgs = {
            host = "lenovo-blue";
            inherit self inputs username;
          };
        };
      };
    };
}
