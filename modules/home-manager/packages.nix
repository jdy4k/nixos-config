{ inputs, lib, pkgs, config, ... }:
{
  home.packages = with pkgs; [
    zip
    unzip
    unrar
    p7zip
    wget
    dig
    traceroute
    file
    imagemagick
    moreutils
    playerctl
    yt-dlp
    
    pavucontrol
    easyeffects
    wine
    veracrypt
  ];
}
