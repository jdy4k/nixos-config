{ username, pkgs, myconfig, ... }:
{
  services = {
    libinput = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    grim
    wlr-randr
    xrandr
    slurp
    wl-clipboard
    direnv
    kdePackages.kscreen
  ];

  programs.hyprland = 
    if myconfig.desktopManager.hyprland.enable then
      {
        enable = true;
        withUWSM = true;
      }
    else
      {
        enable = false; 
      };
}
