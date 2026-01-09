{ username, config, pkgs, ... }:
{
  home.packages = with pkgs; [ ymuse ];
}
