{ ... }:
{
  imports = [ (import ./network.nix) ]
    ++ [ (import ./pipewire.nix) ]
    ++ [ (import ./displayManager/silent-sddm.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./fonts.nix) ]
    ++ [ (import ./wayland.nix) ]
    ++ [ (import ./boot.nix) ]
    ++ [ (import ./xdg.nix) ];
}
