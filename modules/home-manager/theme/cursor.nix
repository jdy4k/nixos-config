{ pkgs, config, ...}:
{
  home.packages = with pkgs; [
    whitesur-cursors
  ];

  #home.sessionVariables = {
  #  XCURSOR_THEME = "WhiteSur-cursors";
  #  XCURSOR_SIZE = 24;
  #};

  home.pointerCursor = {
    name = "WhiteSur-cursors";
    size = 24;
    package = pkgs.whitesur-cursors;
    x11.enable = true;
    gtk.enable = true;
  };
  
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor WhiteSur-cursors 24"
  ];

}
