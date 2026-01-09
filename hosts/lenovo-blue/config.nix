{
  roles ={
    laptop.enable = false;
    amd.enable = false;
    nvidia.enable = true;
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
    art.enable = false;
    japanese.enable = true;
    mpd.enable = true;
  };

  monitors = {
    primary = {
      name = "eDP-1";
      resolution = {
        width = "1920";
        height = "1080";
      };
      refreshRate = "60";
      scale = "1";
    };
  
    left = {
      center = {
        enable = false;
        name = "null";
        wacom = false;
        resolution = {
          width = "1920";
          height = "1080";
        };
        refreshRate = "30";
        scale = "1";
      };
      bottom = {
        enable = false;
        name = "null";
        wacom = false;
        resolution = {
          width = "1920";
          height = "1080";
        };
        refreshRate = "30";
        scale = "1";
      };
    };
  
    right = {
      center = {
        enable = false;
        name = "null";
        wacom = false;
        resolution = {
          width = "1920";
          height = "1080";
        };

        refreshRate = "30";
        scale = "1";
      };
      bottom = {
        enable = false;
        name = "null";
        wacom = false;
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
