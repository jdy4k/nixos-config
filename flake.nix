{
  description = "jdy4k's nixos configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
      url = "github:nix-community/nixvim";
    };
    potatofox = {
      url = "git+https://codeberg.org/da157/PotatoFox";
      flake = false;
    };
    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
    nix-firefox-addons.url = "github:osipog/nix-firefox-addons";
  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      username = "jdy4k"; 
      system = "x86_64-linux";
      tz = "America/New_York";
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
            myconfig = (import ./hosts/lenovo-blue/config.nix);
            inherit self inputs username tz;
          };
        };
	      rock-grey = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./hosts/rock-grey)
          ];
          specialArgs = {
            host = "rock-grey";
            myconfig = (import ./hosts/rock-grey/config.nix);
            inherit self inputs username tz;
          };
        };
      };
    };
}
