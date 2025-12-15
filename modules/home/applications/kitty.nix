{ pkgs, lib, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;

      foreground = "#dddddd";
      background = "#111111";
      window_padding_width = "7 10";
      background_opacity = "0.7";

      font_family = "FiraCode Nerd Font";
      font_size = "14.0";
    };
  };

}
