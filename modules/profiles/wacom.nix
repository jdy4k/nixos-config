{ pkgs, config, lib, myconfig, ... }:
{
  wayland.windowManager.hyprland.settings.device = 
  lib.mkIf config.wayland.windowManager.hyprland.enable {
    name = [ "wacom-cintiq-16-pen" ]; 
    output = "${myconfig.extra.wacom.output}";
  };
}
