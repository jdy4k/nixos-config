{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./mpv.nix) ]
  ++ [ (import ./tesseract-ocr.nix) ]
  ++ [ (import ./goldendict.nix) ];
}
