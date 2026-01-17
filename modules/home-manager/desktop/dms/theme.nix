{ inputs, lib, ... }:
{
  xdg.configFile."DankMaterialShell/settings.json".source = lib.mkForce ./_config/settings.json;
}
