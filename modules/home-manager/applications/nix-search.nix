{ inputs, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    nix-search-tv
  ];
  home.shellAliases = {
    ns = "nix-search-tv print | fzf --preview 'nix-search-tv preview {}' --scheme history";
  };
}
