{ pkgs, input, ... }:
{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload =
        [ "${./../../../../assets/hyprpaper-bg.jpg}" ];
      wallpaper = [
        "eDP-1, ${./../../../../assets/hyprpaper-bg.jpg}"
      ];
    };
  };
}
