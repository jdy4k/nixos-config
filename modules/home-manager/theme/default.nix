{ ... }:
{
  imports = 
     [ (import ./cursor.nix)    ]
  ++ [ (import ./gtk.nix)  ]
  ++ [ (import ./starship.nix)  ]
  ++ [ (import ./qt.nix)  ];
}
