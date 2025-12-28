{ ... }:
{
imports =
    [ (import ./dolphin.nix) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./calibre.nix) ]
    ++ [ (import ./legcord.nix) ]
    ++ [ (import ./nsxiv.nix) ]
    ++ [ (import ./librewolf.nix) ]
    ++ [ (import ./mpv.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./vscodium.nix) ]
    ++ [ (import ./git.nix) ]
    ++ [ (import ./ncmpcpp.nix) ]
    ++ [ (import ./nvim.nix) ]
    
    ++ [ (import ./lf) ];
}
