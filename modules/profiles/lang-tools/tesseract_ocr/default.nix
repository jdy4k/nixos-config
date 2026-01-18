{ config, pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.callPackage ./tesseract-ocr.nix {})
    # Also need tesseract with Japanese
    (pkgs.tesseract.override {
      enableLanguages = [ "jpn" "eng" ];
    })
  ];
}
