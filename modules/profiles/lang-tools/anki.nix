{ pkgs, ... }:
{  
  programs.anki = {
    enable = true;
    minimalistMode = true;

    addons = with pkgs.ankiAddons; [
      anki-connect
      passfail2
      review-heatmap
      pkgs.local.ankiAddons.hanzi2pinyin
      pkgs.local.ankiAddons.japanese
    ];
  };

  home.sessionVariables = {
    #for japanese addon
    ANKI_JAPANESE_DIR = "$HOME/.local/share/Anki2/";
  };
}
