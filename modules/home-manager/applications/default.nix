{ ... }:
{
  imports =
     [ (import ./lf)         ]
  ++ [ (import ./mpv)        ]
  ++ [ (import ./librewolf)  ]

  ++ [ (import ./dolphin.nix)    ]
  ++ [ (import ./chromium.nix)   ]
  ++ [ (import ./obsidian.nix)   ]
  ++ [ (import ./kitty.nix)      ]
  ++ [ (import ./nsxiv.nix)      ]
  ++ [ (import ./nix-search.nix) ]
  ++ [ (import ./zathura.nix)    ]
  ++ [ (import ./git.nix)        ]
  ++ [ (import ./nvim.nix)       ];
}
