{ pkgs, config, myconfig, ... }:
{
  imports =
       [ (import ./MacoESQUE) ]
    ++ (if myconfig.theme.startship.enable
         then [ (import ./startship.nix) ] else [ ]);
}
