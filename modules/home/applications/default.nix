{ ... }:
{
  imports =
       [ (import ./dolphin.nix) ]
    ++ [ (import ./kitty.nix) ]
    ++ [ (import ./nsxiv.nix) ]
    ++ [ (import ./librewolf.nix) ]
    ++ [ (import ./mpv.nix) ]
    ++ [ (import ./zathura.nix) ]
    ++ [ (import ./vscodium.nix) ];
}
