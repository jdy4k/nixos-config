{ input, pkgs, ... }: 
{
  home.packages = with pkgs; [ nsxiv ];
}
