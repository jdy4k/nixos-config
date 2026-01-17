{ pkgs, host, lib, username, myconfig, ... }: 
{
  home.packages = with pkgs; [ hyprshot ];

  wayland.windowManager.hyprland = {
    settings = {
      # monitors
      "debug:disable_scale_checks" = true;
      
      monitor = [( 
        "${myconfig.monitors.primary.name}," +
        "${myconfig.monitors.primary.resolution.width}" +
        "x" +
        "${myconfig.monitors.primary.resolution.height}" +
        "@" +
        "${myconfig.monitors.primary.refreshRate}," +
        "0x0," +
        "${myconfig.monitors.primary.scale}"
      )]

      ++ (if myconfig.monitors.left.enable then
        [("${myconfig.monitors.left.name}," +
        "${myconfig.monitors.left.resolution.width}" +
        "x" +
        "${myconfig.monitors.left.resolution.height}" +
        "@" +
        "${myconfig.monitors.left.refreshRate}," +
        "-${myconfig.monitors.left.resolution.width}x0," +
        "${myconfig.monitors.left.scale}")]
      else [ ])

      ++ (if myconfig.monitors.left.bottom.enable then
        [("${myconfig.monitors.left.bottom.name}," + 
        "${myconfig.monitors.left.bottom.resolution.width}" +
        "x" +
        "${myconfig.monitors.left.bottom.resolution.height}" +
        "@" +
        "${myconfig.monitors.left.bottom.refreshRate}," +
        "-${myconfig.monitors.left.resolution.width}x${myconfig.monitors.left.resolution.height}," +
        "${myconfig.monitors.left.bottom.scale}")]
      else [ ])

      ++ (if myconfig.monitors.right.enable then
        [("${myconfig.monitors.right.name}," +
        "${myconfig.monitors.right.resolution.width}" +
        "x" +
        "${myconfig.monitors.right.resolution.height}" +
        "@" +
        "${myconfig.monitors.right.refreshRate}," +
        "${myconfig.monitors.primary.resolution.width}x0," +
        "${myconfig.monitors.right.scale}")]
      else [ ])

      ++ (if myconfig.monitors.right.bottom.enable then
        [("${myconfig.monitors.right.bottom.name}," + 
        "${myconfig.monitors.right.bottom.resolution.width}" +
        "x" +
        "${myconfig.monitors.right.bottom.resolution.height}" +
        "@" +
        "${myconfig.monitors.right.bottom.refreshRate}," +
        "${myconfig.monitors.primary.resolution.width}x${myconfig.monitors.right.resolution.height}," +
        "${myconfig.monitors.right.bottom.scale}")]
      else [ ])

      ++ [ ", highres, auto, 2, bitdepth, 10" ];

      # autostart
      exec-once = [
        "fcitx5 -dr &"
				"quickshell &"
        ''hyprctl dispatch exec "[workspace special silent]" kitty -1 &''
        "hyprpaper -d"
      ]
        ++ (if myconfig.extra.gaming.enable then [ "steam -silent &" ] else [ ]);

      input = {
        kb_layout = "us,jp";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      render = {
        cm_enabled = false;
      };

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      device = {
        name = [
          "epic-mouse-v1" 
        ];
        sensitivity = -0.5;
      };

      bind = [
        "SUPER, Return, exec, kitty -1"
        "SUPER, Q, killactive,"
        "SUPER, D, exec, anyrun --plugins applications --hide-plugin-info true"
        "SUPER SHIFT, C, movetoworkspace, special"
        "SUPER, C, togglespecialworkspace"
        "SUPER, X, exec, dms ipc call lock lock"
        "SUPER, L, togglefloating,"
        "SUPER, F, fullscreen,"
        "SUPER, P, pin,"
        "SUPER, J, togglesplit,"
        "SUPER, Tab, exec, dms ipc call hypr toggleOverview"
        
        ", PRINT, exec, hyprshot -m region -o ~/Pictures/screenshots/"
        "SHIFT, PRINT, exec, hyprshot -m region -o ~/Pictures/screenshots/ --clipboard-only"
        "SUPER, PRINT, exec, hyprshot -m window -o ~/Pictures/screenshots/"
        "SUPER SHIFT, PRINT, exec, hyprshot -m window -o ~/Pictures/screenshots/ --clipboard-only"
        "ALT, PRINT, exec, hyprshot -m output -o ~/Pictures/screenshots/"
        "ALT SHIFT, PRINT, exec, hyprshot -m output -o ~/Pictures/screenshots/ --clipboard-only"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        " ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
        "SUPER, XF86AudioNext, exec, mpc next"
        "SUPER, XF86AudioPause, exec, mpc toggle"
        "SUPER, XF86AudioPlay, exec, mpc toggle"
        "SUPER, XF86AudioPrev, exec, mpc prev"
      ];

        binde = [
          " ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 1%+"
          " ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 1%-"
        ];

      bindm = [
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      xwayland= {
          force_zero_scaling = true;
      };

      workspace = [
        "name:1, monitor:${myconfig.monitors.primary.name}"
        "name:2, monitor:${myconfig.monitors.primary.name}"
        "name:3, monitor:${myconfig.monitors.primary.name}"
        "name:4, monitor:${myconfig.monitors.primary.name}"
        "name:5, monitor:${myconfig.monitors.primary.name}"
        "name:6, monitor:${myconfig.monitors.primary.name}"
        "name:7, monitor:${myconfig.monitors.primary.name}"
        "name:8, monitor:${myconfig.monitors.primary.name}"
        "name:9, monitor:${myconfig.monitors.primary.name}"
        "name:special, monitor:${myconfig.monitors.primary.name}"
      ]
      ++ (if myconfig.monitors.left.enable then
        ["name:l, monitor:${myconfig.monitors.left.name}, gapsin:0, gapsout:0, default:true"]
      else [ ])
      ++ (if myconfig.monitors.left.bottom.enable then
        ["name:lb, monitor:${myconfig.monitors.left.bottom.name}, gapsin:0, gapsout:0, default:true"]
      else [ ]);

      windowrule = [

      ]
      ++ (if myconfig.monitors.left.enable then [
        "border_size 0, match:float 0, match:workspace name:l"
        "rounding 0, match:float 0, match:workspace name:l"
        "border_size 0, match:float 0, match:workspace name:l"
        "rounding 0, match:float 0, match:workspace name:l"
        ]
      else [ ])
      ++ (if myconfig.monitors.left.bottom.enable then [
        "border_size 0, match:float 0, match:workspace name:lb"
        "rounding 0, match:float 0, match:workspace name:lb"
        "border_size 0, match:float 0, match:workspace name:lb"
        "rounding 0, match:float 0, match:workspace name:lb"
        ]
      else [ ]);

    };
  };
}
