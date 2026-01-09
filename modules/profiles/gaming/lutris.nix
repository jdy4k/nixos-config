{ pkgs, ...}: 
{  
  home.packages = with pkgs; [
    lutris
    gamescope
  ];
}
