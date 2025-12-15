{ ... }:
{
  imports =
       [ (import ./gtk.nix) ]
       ++ [ (import ./qt.nix) ];
}
