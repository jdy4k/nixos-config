{ pkgs, ...}: 
{
  # Configure campscope to be on automatically
  home.packages = with pkgs; [
    lutris
    gamescope
  ];
}
