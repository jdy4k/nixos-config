{
  roles ={
    laptop.enable = false;
    amd.enable = true;
    nvidia.enable = false;
  };
  
  shell = {
    # bash is always enabled; if default is invalid, we be set to bash
    # default : bash, zsh, fish, make sure default option is enabled
    default = "fish";
    fish.enable = true;
    zsh.enable = false;
    
    starship.enable = true;
  };
  
  desktopManager = {
    hyprland.enable = true;
    niri.enable = false;    # Not done
    plasma.enable = false;  # Not done
    i3.enable = false;      # Not done; nixos/x11.nix also not done
  };
  
  # MacoESQUE, TrueAMOLED (TBA), ...
  theme = "MacoESQUE";
  
  extra = {
    art = {
      enable = true;
    };
    wacom = {
      enable = true;
      output = "HDMI-A-1";
    };
    japanese.enable = true;
    mpd.enable = true;
    gaming.enable = true;
    discord.enable = true;
    libreoffice.enable = true;
  };

  monitors = {
    primary = {
      name = "DP-2";
      resolution = {
        width = "3840";
        height = "2160";
      };
      refreshRate = "60";
      scale = "2";
    };
  
    left = {
      enable = true;
      name = "DP-3";
      resolution = {
        width = "1920";
        height = "1080";
      };
      refreshRate = "180";
      scale = "1";
      bottom = {
        enable = true;
        name = "HDMI-A-1";
        wacom = true;
        resolution = {
          width = "1920";
          height = "1080";
        };
        refreshRate = "60";
        scale = "1";
      };
    };
  
    right = {
      enable = false;
      name = "null";
      resolution = {
        width = "1920";
        height = "1080";
      };

      refreshRate = "30";
      scale = "1";

      bottom = {
        enable = false;
        name = "null";
        resolution = {
          width = "1920";
          height = "1080";
        };

        refreshRate = "30";
        scale = "1";
      };
    };
  };
  
}
