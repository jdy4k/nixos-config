{ inputs, ... }:
{
  imports =
     [ (import ./desktop)       ]
  ++ [ (import ./applications)  ]
  ++ [ (import ./shells)        ]
  ++ [ (import ./themes)        ]

  ++ [ (import ./packages.nix)  ]
  ++ [ (import ./variables.nix) ];
}
