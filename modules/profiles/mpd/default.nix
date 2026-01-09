{ inputs, ... }:
{
  imports =
     [ (import ./mpd.nix)     ]
  ++ [ (import ./mpris2.nix)  ]
  ++ [ (import ./ymuse.nix)   ]
  ++ [ (import ./shortwave.nix)   ]
  ++ [ (import ./ncmpcpp.nix) ];
}
