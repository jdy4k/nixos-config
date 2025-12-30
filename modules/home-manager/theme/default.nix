{ pkgs, config, myconfig, ... }:
{
  imports =
       (if myconfig.theme.MacoESQUE.enable
         then [ (import ./MacoESQUE.nix) ] else [ ])
    ++ (if myconfig.theme.starship.enable
         then [ (import ./starship.nix) ] else [ ]);
}
