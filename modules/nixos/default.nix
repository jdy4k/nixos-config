{ ... }:
{
  imports = 
     [ (import ./network.nix)  ]
  ++ [ (import ./pipewire.nix) ]
  ++ [ (import ./system.nix)   ]
  ++ [ (import ./sddm.nix)     ]
  ++ [ (import ./fonts.nix)    ]
  ++ [ (import ./wayland.nix)  ]
  ++ [ (import ./boot.nix)     ]
  ++ [ (import ./xdg.nix)      ];
}
