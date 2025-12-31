{ ... }:
{
  imports =
     [ (import ./lf) ]

  ++ [ (import ./dolphin.nix)   ]
  ++ [ (import ./drawy.nix)   ]
  ++ [ (import ./kitty.nix)     ]
  ++ [ (import ./nsxiv.nix)     ]
  ++ [ (import ./librewolf.nix) ]
  ++ [ (import ./mpv.nix)       ]
  ++ [ (import ./zathura.nix)   ]
  ++ [ (import ./git.nix)       ]
  ++ [ (import ./nvim.nix)      ];
}
