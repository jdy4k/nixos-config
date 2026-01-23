{ ... }:
{
  imports = 
     [ (import ./network.nix)  ]
  ++ [ (import ./pipewire.nix) ]
  ++ [ (import ./system.nix)   ]
  ++ [ (import ./fonts.nix)    ]
  ++ [ (import ./wayland.nix)  ]
  ++ [ (import ./mullvad.nix)  ]
  ++ [ (import ./sddm.nix)     ]
  ++ [ (import ./x11.nix)      ]
  ++ [ (import ./fcitx5.nix)      ]
  ++ [ (import ./boot.nix)     ]
  ++ [ (import ./xdg.nix)      ];
}
