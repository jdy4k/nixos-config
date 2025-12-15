{ ... }:
{
  imports =
       [ (import ./fish.nix) ]
    ++ [ (import ./git.nix) ]
    ++ [ (import ./ncmpcpp.nix) ]
    ++ [ (import ./nvim.nix) ]

    ++ [ (import ./lf) ];
}
