{ inputs, pkgs, config, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../roles/nvidia.nix
    
    ./../../modules/nixos
    ./../../modules/nixos/wayland
    ./../../modules/nixos/extra/fcitx5.nix
    ./../../modules/nixos/extra/mpd.nix

    ./../../modules/home-manager
  ];

  networking.hostName = "lenovo-blue";
  time.timeZone = "America/New_York";
}
