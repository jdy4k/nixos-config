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
    ./../../modules/core
    ./../../modules/extra/coding.nix
  ];

  networking.hostName = "lenovo-blue";
  time.timeZone = "America/New_York";

  hardware.nvidia = {
    open = false;
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  boot = {
    loader = {
    	systemd-boot.enable = true;
	efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };
}
