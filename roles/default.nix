{ inputs, myconfig, ... }:
{
  imports =
     (if myconfig.roles.nvidia.enable
        then [ (import ./nvidia.nix) ] else [ ])
  ++ (if myconfig.roles.amd.enable
        then [ (import ./amd.nix) ]    else [ ])
  ++ (if myconfig.roles.laptop.enable
        then [ (import ./laptop.nix) ] else [ ]);
}
