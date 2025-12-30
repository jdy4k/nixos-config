{ inputs, myconfig, ... }:
{
  imports =
       []
    ++ (if myconfig.extra.japanese.enable then [ ./japanese.nix ] else [])
    ++ (if myconfig.extra.mpd.enable then [ ./mpd ] else []);
}
