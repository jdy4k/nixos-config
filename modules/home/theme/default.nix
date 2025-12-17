{ pkgs, config, ... }:
{
  imports =
       [ (import ./gtk.nix) ]
       ++ [ (import ./qt.nix) ]
       ++ [ (import ./cursor.nix) ];
}
