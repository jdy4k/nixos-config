# Auto-import all subdirectories as Firefox addons
{ pkgs, buildFirefoxXpiAddon }:

let
  entries = builtins.readDir ./.;
  dirs = builtins.filter 
    (name: entries.${name} == "directory") 
    (builtins.attrNames entries);
  
  importAddon = name: import ./${name} { inherit buildFirefoxXpiAddon; };
in
builtins.listToAttrs (map (name: { inherit name; value = importAddon name; }) dirs)

