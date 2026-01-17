{ ... }:
{
  imports = 
     [ (import ./cursor.nix)    ]
  ++ [ (import ./gtk.nix)  ]
  ++ [ (import ./qt.nix)  ];
}
