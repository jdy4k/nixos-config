{ ... }:
{
imports =
       [ (import ./kitty.nix) ]
    ++ [ (import ./nvim.nix)  ];
}
