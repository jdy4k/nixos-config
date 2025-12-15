{
  pkgs,
  host,
  username,
  ...
}: 
{
  wayland.windowManager.hyprland = {
    settings = {

      #source = "~/nixos-config/modules/home/hyprland/displays.conf";

      "debug:disable_scale_checks" = true;
      monitor =
        #if (host == "sakura") then
        #  "eDP-1, 2256x1504@60, 0x0, 1.0"
        #else if (host == "zinnia") then
        #  "eDP-1, 1920x1080@60, 0x0, 1.0"
        #else if (host == "imilia") then
        #  "eDP-1, 1920x1080@60, 0x0, 1.0"
        #else
          ", preferred, auto, auto";

      # autostart
      exec-once = [
        "hyprpaper &"
        "fcitx5 -dr &"
				"quickshell &"
      ];

      input = {
        kb_layout = "us,jp";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      general = {
        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        "$menu" = "flock --nonblock /tmp/.wofi.lock wofi --show drun";
        layout = "dwindle";
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(4169e1aa) rgba(11111100) 45deg";
        "col.inactive_border" = "rgba(11111100)";
        no_border_on_floating = false;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      dwindle = {
        special_scale_factor = 0.9;
        pseudotile = "yes";
        preserve_split = "yes";
      };

      master = {
        new_status = "master";
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5; 
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
          "global,        1,     10,    default                "
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  almostLinear, fade"
          "workspacesIn,  1,     1.21,  almostLinear, fade"
          "workspacesOut, 1,     1.94,  almostLinear, fade"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      bind = [
        "$mainMod, Return, exec, $terminal"
        "$mainMod, Q, killactive,"
        "$mainMod, D, exec, $menu"
        "$mainMod SHIFT, C, movetoworkspace, special"
        "$mainMod, C, togglespecialworkspace"
        "$mainMod, X, exec, hyprlock"
        "$mainMod, V, exec, wl-paste --primary | wl-copy -n"
        "$mainMod, L, togglefloating,"
        "$mainMod, F, fullscreen,"
        "$mainMod, P, pin,"
        "$mainMod, J, togglesplit,"
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
				"$mainMod, TAB, exec, overview-wrapper.sh"

        " ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+ && eww update volume-json='amixer sget Master | jc --amixer'"
        " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && eww update volume-json='amixer sget Master | jc --amixer'"
        " ,XF86AudioMute, exec,        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && eww update volume-json='amixer sget Master | jc --amixer'"
        " ,XF86AudioMicMute, exec,     wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        "$mainMod, XF86AudioNext, exec, mpc next"
        "$mainMod, XF86AudioPause, exec, mpc toggle"
        "$mainMod, XF86AudioPlay, exec, mpc toggle"
        "$mainMod, XF86AudioPrev, exec, mpc prev"
      ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        #"$mainMod, mouse:273, resizewindow"
      ];

      xwayland= {
          force_zero_scaling = true;
      };

      layerrule = [
        "blur,notifications"
        "blur,quickshell"
        "blur, wofi"
      ];

    };
  };
}
