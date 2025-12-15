{ ... }:
{
  imports =
       [ (import ./terminal-tools) ]
    ++ [ (import ./hyprland) ]
    ++ [ (import ./applications) ]
    ++ [ (import ./theme) ]

    ++ [ (import ./packages.nix) ]
    ++ [ (import ./variables.nix) ];
}
