{ pkgs, host, lib, username, myconfig, ... }: 
{
  wayland.windowManager.hyprland = {
    settings = {
      # monitors
      "debug:disable_scale_checks" = true;
      monitor = lib.concatStrings [ 
        "${myconfig.monitors.primary.name},"

        "${myconfig.monitors.primary.resolution.width}"
        "x"
        "${myconfig.monitors.primary.resolution.height}"
        "@"
        "${myconfig.monitors.primary.refreshRate},"

        "0x0,"

        "${myconfig.monitors.primary.scale}"
      ];

      ### More monitors with conditiona logic go below
      # ...
      # ...

      # autostart
      exec-once = [
        "hyprpaper &"
        "hyprsunset &"
        "fcitx5 -dr &"
				"quickshell &"
        ''hyprctl dispatch exec "[workspace special silent]" kitty -1''
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
        "$terminal" = "kitty -1";
        "$menu" = "flock --nonblock /tmp/.wofi.lock wofi --show drun";
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
        # Enable Wacom tablet here or in the art profile
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

        binde = [
          " ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+ && eww update volume-json='amixer sget Master | jc --amixer'"
          " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%- && eww update volume-json='amixer sget Master | jc --amixer'"
        ];

      bindm = [
        "$mainMod, mouse:272, movewindow"
        #"$mainMod, mouse:273, resizewindow"
      ];

      xwayland= {
          force_zero_scaling = true;
      };

    };
  };
}
