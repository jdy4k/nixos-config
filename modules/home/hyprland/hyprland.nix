{ inputs, pkgs, config, ... }:
{
  home.packages = with pkgs; [
    
    # Wayland session
    quickshell        # Widgets
    grim		          # Screenshot
    slurp	      	    # Screen selection
    wl-clipboard	    # Clipboard
    libnotify
    direnv
		socat

    # Theme
    whitesur-cursors
  ];

  home.sessionVariables = {
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    ANKI_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    GTK_CSD = "0";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    
    XCURSOR_THEME = "WhiteSur-cursors";
    XCURSOR_SIZE = 24;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    systemd.enable = true;
    
    plugins = [
      #pkgs.hyprlandPlugins.hyprspace
    ];
  };
}
