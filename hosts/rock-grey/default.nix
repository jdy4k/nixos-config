{ inputs, pkgs, config, lib, username, host, tz, myconfig, ... }:
{
  ### HOST VARS ###
  networking.hostName = "${host}";
  time.timeZone = "${tz}";

  ### NIXOS ###

  imports = 
     [ (import ./hardware-configuration.nix)         ]
    ++ [ (import ./../../modules/nixos/boot.nix)     ] 
    ++ [ (import ./../../modules/nixos)                ] 
    ++ [ (import ./../../roles)                        ]
    ++ [ inputs.home-manager.nixosModules.home-manager ];

  ### HOME MANAGER ###
  
    home-manager = {
  
      useUserPackages = true;
      useGlobalPkgs = true;
  
      backupFileExtension = "bak";
      extraSpecialArgs = {
        inherit inputs username host myconfig pkgs; 
      };
      users.${username} = {
        imports = 
           [ ./../../modules/home-manager ]
        ++ [ ./../../modules/theme        ]
        ++ [ ./../../modules/profiles     ];
        home = {
          username = "${username}";
          homeDirectory = "/home/${username}";
          stateVersion = "25.11";
        };
        programs.home-manager.enable = true;
      };
    };

  ### USERS ###

  # Main user
  programs.bash.enable = true;
  programs.fish.enable = (myconfig.shell.fish.enable);
  programs.zsh.enable = (myconfig.shell.zsh.enable);

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = if (myconfig.shell.default == "fish" || myconfig.shell.fish.enable)
              then pkgs.fish else
            if (myconfig.shell.default == "zsh"  || myconfig.shell.zsh.enable)
              then pkgs.zsh else
            if (myconfig.shell.default == "bash")
              then pkgs.bash
            else
              pkgs.bash;
  };
  nix.settings.allowed-users = [ "${username}" ];

  # Additional users
  # ...

}
