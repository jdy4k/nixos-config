{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-gtk
    gnome-keyring
    alsa-utils
    gcc
    git
  ];
}
