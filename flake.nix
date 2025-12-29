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
      myconfig = {
        shell = {
          deault = "fish";
          fish = true;
          zsh = true;
        };
        timeZone = "America/New_York";
        compositor = "wayland";
        desktopManager = {
          hyprland = true;
          theme = "macO_esque";
        };

        displayManager = {
          sddm = true;
          theme = "slient-sddm";
        };

        japaneseSupport = true;

        monitors = {
          primary = {
            name = "eDP-1";
            resolution = {
              width = "1920";
              height = "1080";
            };
            refreshRate = "60";
            scale = "1";
          };

          left = {
            center = {
              enabled = false;
              name = "null";
              resolution = "null";
              refreshRate = 0;
              scale = 0;
            };
            bottom = {
              enabled = false;
              name = "null";
              resolution = "null";
              refreshRate = 0;
              scale = 0;
            };
          };

          right = {
            center = {
              enabled = false;
              name = "null";
              resolution = "null";
              refreshRate = 0;
              scale = 0;
            };
            bottom = {
              enabled = false;
              name = "null";
              resolution = "null";
              refreshRate = 0;
              scale = 0;
            };
          };
        };
      };
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
            inherit self inputs username myconfig;
          };
        };
      };
    };
}
