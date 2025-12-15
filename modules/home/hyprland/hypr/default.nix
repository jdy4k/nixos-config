{ inputs, ... }:
{
  imports =
    [ (import ./hyprlock.nix) ]
    ++ [ (import ./hyprpaper.nix) ];
}
