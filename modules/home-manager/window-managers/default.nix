{ inputs, myconfig, ... }:
{
  imports =
     (if myconfig.desktopManager.hyprland.enable
        then [ (import ./hyprland) ] else [ ]);
}
