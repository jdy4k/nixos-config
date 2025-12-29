{ inputs, ... }:
{
  imports =
       [ (import ./hyprland) ]
    ++ [ (import ./applications) ]
    ++ [ (import ./theme) ]
    ++ [ (import ./extra) ]

    #    ++ [ (import ./fish.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./variables.nix) ];
}
