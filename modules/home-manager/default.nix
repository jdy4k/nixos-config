{ inputs, ... }:
{
  imports =
     [ (import ./window-managers) ]
  ++ [ (import ./applications)    ]
  ++ [ (import ./shells)          ]
  ++ [ (import ./themes)          ]

  ++ [ (import ./packages.nix)    ]
  ++ [ (import ./variables.nix)   ];
}
