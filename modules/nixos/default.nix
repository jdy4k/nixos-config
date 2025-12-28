{ ... }:
{
  imports = [ (import ./network.nix) ]
    ++ [ (import ./pipewire.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./user.nix) ]
    ++ [ (import ./boot.nix) ]
    ++ [ (import ./xdg.nix) ]
}
