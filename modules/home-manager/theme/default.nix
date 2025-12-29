{ pkgs, config, ... }:
{
  imports =
       [ (import ./gtk.nix) ]
       ++ [ (import ./qt.nix) ]
       ++ [ (import ./starship.nix) ]
       ++ [ (import ./cursor.nix) ];
}
