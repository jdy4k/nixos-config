# Auto-import all subdirectories as packages
{ pkgs }:

let
  inherit (builtins) readDir attrNames filter;
  inherit (pkgs.lib) filterAttrs;
  
  # Get all directories in this folder
  entries = readDir ./.;
  dirs = attrNames (filterAttrs (name: type: type == "directory") entries);
  
  # Import each directory as a package
  importPkg = name: pkgs.callPackage ./${name} { };
in
builtins.listToAttrs (map (name: { inherit name; value = importPkg name; }) dirs)

