{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./mpv) ]
  ++ [ (import ./tesseract-ocr.nix) ]
  ++ [ (import ./goldendict.nix) ];
}
