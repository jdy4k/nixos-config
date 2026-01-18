{ ... }:
{
  imports = 
     [ (import ./anki.nix) ]
  ++ [ (import ./mpv) ]
  ++ [ (import ./tesseract_ocr) ]
  ++ [ (import ./goldendict) ];
}
