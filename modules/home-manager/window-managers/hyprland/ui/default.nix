{ inputs, ... }:
{
  imports =
    [ (import ./wofi.nix) ]
    ++ [ (import ./quickshell) ]
    ++ [ (import ./dunst.nix) ];
}
