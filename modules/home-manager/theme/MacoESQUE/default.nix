{ pkgs, config, ... }:
{
  imports =
       [ (import ./gtk.nix) ]
       ++ [ (import ./qt.nix) ]
       ++ [ (import ./cursor.nix) ]

       ++ [ (import ./widgets.nix) ]
       ++ [ (import ./applications.nix) ]
       ++ [ (import ./window-managers.nix) ];
}
