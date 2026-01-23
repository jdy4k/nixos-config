{ pkgs, config, ... }:
{
  imports = [ ./lfimg.nix ];

  programs.lf = {
    enable = true;
    keybindings = {
      "a" = ":push %touch<space>''<left>";
      "A" = ":push %mkdir<space>''<left>";
      "<delete>" = ":delete";
      "<right>" = ":open";
      "b" = "$vidir";
      "E" = "!atool -x \"$fx\"";
    };
  };
}
