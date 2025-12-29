{ inputs, pkgs, config, lib, username, host, ... }:
{
  networking.hostName = "lenovo-blue";
  time.timeZone = "America/New_York";

  imports = [
    ./hardware-configuration.nix
    ./../../roles/nvidia.nix
    
    ./../../modules/nixos
    ./../../modules/nixos/wayland
    #./../../modules/nixos/extra/fcitx5.nix
    #./../../modules/nixos/extra/mpd.nix

    inputs.home-manager.nixosModules.home-manager
  ];

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

  programs.fish.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };
  nix.settings.allowed-users = [ "${username}" ];
}
