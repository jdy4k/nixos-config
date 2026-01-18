{ pkgs, ... }:
{
  home.packages = with pkgs; [
    local.tesseract-ocr
  ];
}
