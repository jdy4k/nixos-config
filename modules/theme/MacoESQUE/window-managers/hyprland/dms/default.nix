{
  inputs,
  lib,
  ...
}:
{
  xdg.configFile."DankMaterialShell/settings.json".source = lib.mkForce ./settings.json;
}
