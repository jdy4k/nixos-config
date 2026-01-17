{
  pkgs,
  host,
  lib,
  username,
  myconfig,
  ...
}: let
  bg = "${./../../../../assets/wallpaper.jpg}";
  avatar = "${./../../../../assets/avatar.jpg}";
in
{
  wayland.windowManager.hyprland = {

    settings = {
      exec-once = [
        "dms ipc call profile setImage ${bg}"
        "dms ipc call wallpaper set ${avatar}"
      ];
      general = {
        layout = "dwindle";
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(4169e1aa) rgba(11111100) 45deg";
        "col.inactive_border" = "rgba(11111100)";
      };


      dwindle = {
        special_scale_factor = 0.9;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      decoration = {
        rounding = 5;
        rounding_power = 10;
        active_opacity = 1.0;
        inactive_opacity = 1.0;
        fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];

        animation = [
          "global,        1,     5,     default                "
          "border,        1,     2.695, easeOutQuint"
          "windows,       1,     2.395, easeOutQuint"
          "windowsIn,     1,     2.05,  easeOutQuint, popin 87%"
          "windowsOut,    1,     0.745, linear,       popin 87%"
          "fadeIn,        1,     0.865, almostLinear"
          "fadeOut,       1,     0.73,  almostLinear"
          "fade,          1,     1.515, quick"
          "layers,        1,     1.905, easeOutQuint"
          "layersIn,      1,     2,     easeOutQuint, fade"
          "layersOut,     1,     0.75,  linear,       fade"
          "fadeLayersIn,  1,     0.895, almostLinear"
          "fadeLayersOut, 1,     0.695, almostLinear"
          "workspaces,    1,     0.97,  almostLinear, fade"
          "workspacesIn,  1,     0.605, almostLinear, fade"
          "workspacesOut, 1,     0.97,  almostLinear, fade"
          "zoomFactor,    1,     3.5,   quick"
        ];
      };
    };
  };
}
