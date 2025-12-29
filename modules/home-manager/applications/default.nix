{ ... }:
{
imports =
    [ (import ./dolphin.nix) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./nsxiv.nix) ]
    ++ [ (import ./librewolf.nix) ]
    ++ [ (import ./mpv.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./git.nix) ]
    ++ [ (import ./nvim.nix) ]
    
    ++ [ (import ./lf) ];
}
