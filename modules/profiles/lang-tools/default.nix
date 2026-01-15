{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./goldendict.nix) ]
}
