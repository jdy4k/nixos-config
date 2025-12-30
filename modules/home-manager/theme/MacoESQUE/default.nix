{ pkgs, config, ... }:
{
  imports =
       [ (import ./gtk.nix) ]
       ++ [ (import ./qt.nix) ]
       ++ [ (import ./cursor.nix) ]

       ++ [ (import ./widgets) ]
       ++ [ (import ./applications) ]
       ++ [ (import ./window-managers) ];
}
