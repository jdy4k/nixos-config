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
    };
  };

}
