{ ... }:
{
  imports = [ (import ./network.nix) ]
    ++ [ (import ./pipewire.nix) ]
    ++ [ (import ./system.nix) ]
    ++ [ (import ./user.nix) ]
    ++ [ (import ./wayland.nix) ]
    ++ [ (import ./fcitx5.nix) ]
    ++ [ (import ./mpd.nix) ]
    ++ [ (import ./packages.nix) ]
    ++ [ (import ./silent-sddm.nix) ];
}
