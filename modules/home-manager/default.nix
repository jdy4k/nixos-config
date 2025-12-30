{ inputs, ... }:
{
  imports =
       [ (import ./window-managers) ]
    ++ [ (import ./applications) ]
    ++ [ (import ./theme) ]
    ++ [ (import ./shells) ]

    ++ [ (import ./packages.nix) ]
    ++ [ (import ./variables.nix) ];
}
