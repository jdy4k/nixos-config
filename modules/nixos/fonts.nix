{ pkgs, inputs, ... }:
{
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.font-awesome

    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.liberation_ttf
    pkgs.takao
    pkgs.ipaexfont

    inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
  ];
}
