{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xdg-utils
    xdg-desktop-portal-gtk
    gnome-keyring
    alsa-utils
		cmake
		gnumake
		meson
		ninja
  ];
}
