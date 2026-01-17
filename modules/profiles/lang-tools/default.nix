{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./mpv) ]
  ++ [ (import ./goldendict) ];
}
