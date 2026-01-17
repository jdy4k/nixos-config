{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./owocr.nix) ]
  ++ [ (import ./goldendict.nix) ];
}
