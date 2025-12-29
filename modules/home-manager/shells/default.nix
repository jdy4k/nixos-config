{ inputs, myconfig, ... }:
{
  imports =
       [ (import ./bash.nix) ]
    ++ (if myconfig.shell.fish.enable then [ (import ./fish.nix) ] else [ ])
    ++ (if myconfig.shell.zsh.enable then [ (import ./zsh.nix) ] else [ ]);
}
