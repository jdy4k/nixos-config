{ username, pkgs, ... }:
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

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
}
