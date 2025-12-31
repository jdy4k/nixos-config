{ inputs, ... }:
{
  imports =
     [ (import ./window-managers) ]
  ++ [ (import ./applications)    ]
  ++ [ (import ./shells)          ]

  ++ [ (import ./packages.nix)    ]
  ++ [ (import ./variables.nix)   ];
}
