{ pkgs, lib, ... }:
{
  programs.kitty = lib.mkForce {
    settings = {
      foreground = "#dddddd";
      background = "#111111";
      window_padding_width = "8";
      background_opacity = "0.7";

      font_family = "FiraCode Nerd Font";
      font_size = "13.0";
    };
  };

}
