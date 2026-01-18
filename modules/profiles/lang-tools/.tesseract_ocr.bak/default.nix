{ config, pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./tesseract-ocr.nix {})
    # Also need tesseract with Japanese
    #(pkgs.tesseract.override {
    #  enableLanguages = [ "jpn" "eng" ];
    #})
  ];
}
