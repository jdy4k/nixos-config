{ inputs, pkgs, config, lib, username, host, tz, myconfig, ... }:
{
  ### HOST VARS ###
  networking.hostName = "lenovo-blue";
  time.timeZone = "${tz}";

  ### NIXOS ###

  imports = 
    [ (import ./hardware-configuration.nix) ]
 ++ [ (import ./../../modules/nixos { inherit myconfig; }) ] 
 ++ [ (import ./../../roles) ]
 ++ [ inputs.home-manager.nixosModules.home-manager ];

  ### HOME MANAGER ###

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {
      inherit inputs username host myconfig; 
    };
    users.${username} = {
      imports = [ ./../../modules/home-manager ]
             ++ [ ./../../modules/packs ];
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
  programs.fish.enable = 
    if myconfig.shell.fish.enable then true else false;
  programs.zsh.enable = 
    if myconfig.shell.zsh.enable then true else false;

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
