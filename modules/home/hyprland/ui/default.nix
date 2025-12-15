{ inputs, ... }:
{
  imports =
    [ (import ./wofi.nix) ]
    ++ [ (import ./dunst.nix) ];
}
