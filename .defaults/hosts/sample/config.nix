{
  roles ={
    laptop.enable = false;
    amd.enable = false;
    nvidia.enable = false;
  };
  
  shell = {
    # bash is always enabled
    default = "bash";
    fish.enable = false;
    zsh.enable = false;
  };
  
  desktopManager = {
    hyprland = {
      enable = true;
    };
    niri = {
      enable = false;
    };
    KDE = {
      enable = false;
    };
    i3 = {
      enable = false;
    };
  };
  
  displayManager = {
    sddm = {
      enable = false;
      theme = "null";
    };
  };

  theme = {
    # MacoESQUE and (TBA) TrueAMOLED; 
    MacoESQUE.enable = false;
    starship.enable = false;
  };
  
  extra = {
    art.enable = false;
    japanese.enable = false;
    mpd.enable = false;
  };

  monitors = {
    primary = {
      name = "null";
      resolution = {
        width = "null";
        height = "null";
      };
      refreshRate = "30";
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
        refreshRate = "30";
        scale = "1";
      };
      bottom = {
        enable = false;
        name = "null";
        resolution = {
          width = "0";
          height = "0";
        };
        refreshRate = "30";
        scale = "1";
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

        refreshRate = "30";
        scale = "1";
      };
      bottom = {
        enable = false;
        name = "null";
        resolution = {
          width = "0";
          height = "0";
        };

        refreshRate = "30";
        scale = "1";
      };
    };
  };
  
}
