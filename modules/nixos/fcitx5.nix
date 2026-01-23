{ pkgs, ... }:
{
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc # Japanese
        fcitx5-rime # Chinese
        fcitx5-gtk
      ];
    };
  };

  environment.sessionVariables = rec {
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };
}
