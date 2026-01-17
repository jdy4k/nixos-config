{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./goldendict) ];
}
