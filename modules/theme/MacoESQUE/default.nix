{ ... }:
{
  imports = 
     [ (import ./applications)  ]
  ++ [ (import ./window-managers)   ]

  ++ [ (import ./cursor.nix)    ]
  ++ [ (import ./gtk.nix)  ]
  ++ [ (import ./qt.nix)  ];
}
