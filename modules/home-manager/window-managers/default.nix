{ inputs, ... }:
{
  imports =
      [ ] 
   ++ (if myconfig.desktopManager.enable
        then [ (import ./hyprland) ] else [ ]);
}
