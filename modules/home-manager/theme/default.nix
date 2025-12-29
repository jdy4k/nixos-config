{ pkgs, config, ... }:
{
  imports =
       [ (import ./gtk.nix) ]
       ++ [ (import ./qt.nix) ]
       ++ [ (import ./starship.nix) ]
       ++ [ (import ./silent-sddm.nix) ]
       ++ [ (import ./cursor.nix) ];
}
