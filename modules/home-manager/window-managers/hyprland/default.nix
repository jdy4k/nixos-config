{ inputs, pkgs, config, ... }:
{
  imports =
     [ (import ./config.nix) ]
  ++ [ (import ./anyrun.nix) ]
  ++ [ (import ./dms.nix)    ];

  home.sessionVariables = {
    DISABLE_QT5_COMPAT = "0";
    GDK_BACKEND = "wayland";
    GDK_SCALE = "2";
    ANKI_WAYLAND = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_QPA_PLATFORM = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_SESSION_TYPE = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    GOLDENDICT_FORCE_WAYLAND = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
    };
    systemd.enable = false;
  };
}
