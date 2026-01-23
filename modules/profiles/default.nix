{ inputs, myconfig, ... }:
{
  imports =
     (if myconfig.extra.wacom.enable
      then [ ./wacom.nix       ] else [ ])
  ++ (if myconfig.extra.discord.enable     
      then [ ./discord.nix     ] else [ ])
  ++ (if myconfig.extra.libreoffice.enable 
      then [ ./libreoffice.nix ] else [ ])
  ++ (if myconfig.extra.mpd.enable         
      then [ ./mpd             ] else [ ])
  ++ (if myconfig.extra.gaming.enable      
      then [ ./gaming          ] else [ ])
  ++ (if myconfig.extra.lang-tools.enable      
      then [ ./lang-tools      ] else [ ])
  ++ (if myconfig.extra.art.enable         
      then [ ./art             ] else [ ]);
}
