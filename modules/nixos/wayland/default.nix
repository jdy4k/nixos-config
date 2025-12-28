{ ... }:
{
  imports = [ (import ./wayland.nix) ]
    ++ [ (import ./silent-sddm.nix) ]
}
