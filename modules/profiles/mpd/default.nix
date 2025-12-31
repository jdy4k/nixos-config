{ inputs, ... }:
{
  imports =
     [ (import ./mpd.nix)     ]
  ++ [ (import ./ncmpcpp.nix) ];
}
