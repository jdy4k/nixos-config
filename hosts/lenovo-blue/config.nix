{
  roles ={
    laptop = true;
    amd = false;
    nvidia = true;
  };
  
  shell = {
    # bash is always enabled
    default = "fish";
    fish.enable = true;
    zsh.enable = false;
  };
  
  desktopManager = {
    hyprland = {
      enable = true;
    };
  };
  
  displayManager = {
    sddm = {
      enable = true;
      theme = "silent-sddm";
    };
  };

  theme = {
    # MacoESQUE and (TBA) TrueAMOLED; 
    MacoESQUE.enable = true;
    starship.enable = true;
  };
  
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
        resolution = {
          width = "0";
          height = "0";
        };
        refreshRate = 0;
        scale = 0;
      };
      bottom = {
        enable = false;
        name = "null";
        resolution = {
          width = "0";
          height = "0";
        };
        refreshRate = 0;
        scale = 0;
      };
    };
  
    right = {
      center = {
        enable = false;
        name = "null";
        resolution = {
          width = "0";
          height = "0";
        };

        refreshRate = 0;
        scale = 0;
      };
      bottom = {
        enable = false;
        name = "null";
        resolution = {
          width = "0";
          height = "0";
        };

        refreshRate = 0;
        scale = 0;
      };
    };
  };
  
}
