{ pkgs, lib, ... }:
{
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      use_gpu = 0;
      dynamic_background_opacity = true;
      enable_audio_bell = false;
      shell_integration = "disabled";
      foreground = "#dddddd";
      background = "#111111";
      window_padding_width = "8";
      background_opacity = "0.7";
      font_family = "FiraCode Nerd Font";
      font_size = "13.0";
    };
  };

}
