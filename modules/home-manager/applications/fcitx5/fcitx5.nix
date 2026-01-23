{ pkgs, ... }:
{
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc # Japanese
        fcitx5-rime # Chinese
        rime-data
        fcitx5-gtk
      ];
    };
  };

  home.sessionVariables = {
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

  xdg.configFile."fcitx5/config".source = ./_conf/config;
  xdg.configFile."fcitx5/profile".source = ./_conf/profile;
}
