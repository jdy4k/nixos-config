# Auto-import all subdirectories as Anki addons
{ pkgs }:

let
  entries = builtins.readDir ./.;
  dirs = builtins.filter 
    (name: entries.${name} == "directory") 
    (builtins.attrNames entries);
  
  importAddon = name: import ./${name} { inherit pkgs; };
in
builtins.listToAttrs (map (name: { inherit name; value = importAddon name; }) dirs)


