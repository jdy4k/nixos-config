{ inputs, ... }:
{
  imports =
       [ (import ./window-managers) ]
    ++ [ (import ./applications) ]
    ++ [ (import ./widgets) ]
    ++ [ (import ./theme) ]
    ++ [ (import ./shells) ]
    ++ [ (import ./extra) ]

    ++ [ (import ./packages.nix) ]
    ++ [ (import ./variables.nix) ];
}
