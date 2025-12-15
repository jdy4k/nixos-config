{ inputs, ... }:
{
  imports =
    [ (import ./hyprland.nix) ]
    ++ [ (import ./config.nix) ]
    ++ [ (import ./hypr) ]
    ++ [ (import ./ui) ];
}
