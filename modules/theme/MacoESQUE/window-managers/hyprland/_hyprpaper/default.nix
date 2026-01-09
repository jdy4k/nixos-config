{ pkgs, input, myconfig, ... }:
#let
#  bg = ./../../../../../../assets/hyprpaper-bg.jpg;
#in
{
  xdg.configFile."hypr/hyprpaper.conf".source = ./hyprpaper.conf;
}
