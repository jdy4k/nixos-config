{ pkgs, config, myconfig, ... }:
{
  imports =
       (if myconfig.theme == "MacoESQUE"
         then [ (import ./MacoESQUE)  ] else
        if myconfig.theme == "TrueAMOLED"
         then [ (import ./TrueAMOLED) ]
        else [ ]);
}
