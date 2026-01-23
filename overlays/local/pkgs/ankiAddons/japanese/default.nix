{ pkgs }:

pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
  pname = "Japanese";
  version = "v25.5.15.0";
  src = pkgs.lib.cleanSource ./addon;
  sourceRoot = "${finalAttrs.src.name}/japanese";
})
