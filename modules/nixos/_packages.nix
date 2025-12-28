{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-gtk
    alsa-utils
  ];
}
