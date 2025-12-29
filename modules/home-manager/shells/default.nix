{ inputs, myconfig, ... }:
{
  imports =
       [ (import ./bash.nix) ]
    ++ (if myconfig.shell.fish then [ (import ./fish.nix) ] else [ ])
    ++ (if myconfig.shell.zsh then [ (import ./zsh.nix) ] else [ ]);
}
