{ pkgs, ... }:
{
  i18n = {
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
    supportedLocales = [                
      "en_US.UTF-8/UTF-8"                    
      "ja_JP.UTF-8/UTF-8"                    
    ];
  };

    environment.sessionVariables = rec {
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
  };

}
