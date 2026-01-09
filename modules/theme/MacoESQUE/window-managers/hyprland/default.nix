{ inputs, pkgs, config, ... }:
{
  imports =
    [ (import ./config.nix) ]
    ++ [ (import ./dms) ]
    ++ [ (import ./anyrun) ];
}
