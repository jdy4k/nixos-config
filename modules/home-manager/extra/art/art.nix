{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    krita
    gimp
    aseprite
    blender
  ];
}
