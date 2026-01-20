# Auto-import all subdirectories as packages
# Excludes firefoxAddons and ankiAddons which need special handling
{ pkgs }:

let
  entries = builtins.readDir ./.;
  excludedDirs = [ "firefoxAddons" "ankiAddons" ];
  dirs = builtins.filter 
    (name: entries.${name} == "directory" && !(builtins.elem name excludedDirs)) 
    (builtins.attrNames entries);
  
  importPkg = name: pkgs.callPackage ./${name} { };
in
builtins.listToAttrs (map (name: { inherit name; value = importPkg name; }) dirs)

