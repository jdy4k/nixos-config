{ inputs, pkgs, config, lib, username, host, myconfig, ... }:
{

  ### HOST VARS ###
  networking.hostName = "lenovo-blue";
  time.timeZone = "${myconfig.timeZone}";

  ### NIXOS ###

  imports = [
    ./hardware-configuration.nix
    ./../../roles/nvidia.nix
    
    ./../../modules/nixos
    ./../../modules/nixos/wayland

    inputs.home-manager.nixosModules.home-manager # Enables section below
  ];

  ### HOME MANAGER ###

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {

      inherit inputs username host; 
    };
    users.${username} = {
      imports = [ ./../../modules/home-manager ];
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
  programs.fish.enable = if (myconfig.shell == "fish") then true else false;
  programs.zsh.enable = if (myconfig.shell == "zsh") then true else false;
  #programs.bash.enable = true;

  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = if (myconfig.shell.default == "fish") then 
              pkgs.fish
            else if (myconfig.shell.default == "zsh") then
              pkgs.zsh
            else if (myconfig.shell.default == "bash") then
              pkgs.bash
            else
              pkgs.bash;
  };
  nix.settings.allowed-users = [ "${username}" ];

  # Additional users
  # ...

}
