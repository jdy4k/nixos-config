{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    goldendict-ng
    anki
  ];
}