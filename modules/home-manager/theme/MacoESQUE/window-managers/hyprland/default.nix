{ inputs, pkgs, config, ... }:
{
  imports =
    [ (import ./config.nix) ]
    ++ [ (import ./hypr) ];
}
