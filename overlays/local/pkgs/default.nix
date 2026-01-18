# Auto-import all subdirectories as packages
{ pkgs }:

let
  entries = builtins.readDir ./.;
  dirs = builtins.filter 
    (name: entries.${name} == "directory") 
    (builtins.attrNames entries);
  
  importPkg = name: pkgs.callPackage ./${name} { };
in
builtins.listToAttrs (map (name: { inherit name; value = importPkg name; }) dirs)

