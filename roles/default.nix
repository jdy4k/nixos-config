{ inputs, myconfig, ... }:
{
  imports =
     (if myconfig.role.nvidia.enable
        then [ (import ./nvidia.nix) ] else [ ])
  ++ (if myconfig.role.amd.enable
        then [ (import ./amd.nix) ] else [ ])
  ++ (if myconfig.role.laptop.enable
        then [ (import ./laptop.nix) ] else [ ]);
}
