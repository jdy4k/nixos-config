{ pkgs, config, myconfig, ... }:
{
  imports =
       [ (import ./MacoESQUE) ]
    ++ (if myconfig.theme.starship.enable
         then [ (import ./starship.nix) ] else [ ]);
}
