{ inputs, ... }:
{
  imports =
       [ (import ./hyprland) ]
    ++ [ (import ./applications) ]
    ++ [ (import ./theme) ]
    ++ [ (import ./shells) ]
    ++ [ (import ./extra) ]

    ++ [ (import ./packages.nix) ]
    ++ [ (import ./variables.nix) ];
}
