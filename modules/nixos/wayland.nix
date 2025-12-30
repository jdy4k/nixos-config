{ username, pkgs, myconfig, ... }:
{
  services = {
    libinput = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    grim
    slurp
    wl-clipboard
    direnv
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
