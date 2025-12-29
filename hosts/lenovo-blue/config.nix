{
  timeZone = "America/New_York";
  
  roles ={
    laptop = true;
    amd = false;
    nvidia = true;
  };
  
  shell = {
    default = "fish";
    fish.enable = true;
    zsh.enable = true;
  };
  
  desktopManager = {
    hyprland = {
      enabled = true;
      theme = "macO_esque";
    };
  };
  
  displayManager = {
    sddm = {
      enable = true;
      theme = "slient-sddm";
    };
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
        enabled = false;
        name = "null";
        resolution = "null";
        refreshRate = 0;
        scale = 0;
      };
      bottom = {
        enabled = false;
        name = "null";
        resolution = "null";
        refreshRate = 0;
        scale = 0;
      };
    };
  
    right = {
      center = {
        enabled = false;
        name = "null";
        resolution = "null";
        refreshRate = 0;
        scale = 0;
      };
      bottom = {
        enabled = false;
        name = "null";
        resolution = "null";
        refreshRate = 0;
        scale = 0;
      };
    };
  };
  
  extra = {
    art.enable = false;
    japanese.enable = true;
    mpd.enable = true;
  };
  
}
