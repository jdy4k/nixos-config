{ pkgs, ... }:
{
  programs.anki = {
    enable = true;
    addons = [ 
      pkgs.ankiAddons.anki-connect
      pkgs.ankiAddons.passfail2
      pkgs.ankiAddons.review-heatmap
    ];
  };

  xdg.dataFile."Anki2/addons21/ajt_japanese".source = ./addons/ajt_japanese;
}
