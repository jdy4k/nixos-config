{ pkgs, input, myconfig, ... }:
let
  bg = ./../../../../../../assets/hyprpaper-bg.jpg;
in
{
  services.hyprpaper = {
    settings = {
      preload =
        [ "${bg}" ];
      wallpaper = [
        "${myconfig.monitors.primary.name}, ${bg}"
      ];
    };
  };
}
