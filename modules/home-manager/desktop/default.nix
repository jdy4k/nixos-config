{ ... }:
{
  imports = 
     [ (import ./anyrun)   ]
  ++ [ (import ./dms)      ]
  ++ [ (import ./hyprland) ];
}
