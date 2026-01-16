{ pkgs, ... }:

let
  gd-tools = pkgs.callPackage ./gd-tools.nix { };
in
{
  home.packages = with pkgs; [
    goldendict-ng
    mecab
    mecab-ipadic  # Japanese dictionary for mecab
    gd-tools
  ];
}
