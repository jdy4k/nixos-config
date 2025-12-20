{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./roles/nvidia.nix
    ./../../modules/core
    ./../../modules/extra/coding.nix
    ./../../modules/extra/gaming.nix
  ];

  networking.hostName = "lenovo-blue";
  time.timeZone = "America/New_York";

  boot = {
    loader = {
    	systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
