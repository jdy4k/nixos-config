{ config, pkgs, lib, ... }:
{
  hardware.nvidia = {
    open = false;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
}
