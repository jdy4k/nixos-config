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

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}
