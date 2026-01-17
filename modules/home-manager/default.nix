{ inputs, ... }:
{
  imports =
     [ (import ./desktop)       ]
  ++ [ (import ./applications)  ]
  ++ [ (import ./shells)        ]
  ++ [ (import ./theme)         ]

  ++ [ (import ./packages.nix)  ]
  ++ [ (import ./variables.nix) ];
}
