{ inputs, ... }:
{
  imports =
    [ (import ./hyprlock.nix) ]
    ++ [ (import ./hyprsunset.nix) ]
    ++ [ (import ./hyprpaper.nix) ];
}
