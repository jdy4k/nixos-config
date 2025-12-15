{ username, pkgs, ... }:
{
  services = {
    libinput = {
      enable = true;
    };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  security.rtkit.enable = true;
  xdg.autostart.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
}
