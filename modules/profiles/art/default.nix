{ ... }:
{
  imports = 
     [ (import ./blender.nix) ]
  ++ [ (import ./gimp.nix)    ]
  ++ [ (import ./krita.nix)   ]
  ++ [ (import ./godot.nix)   ];
}
