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
      
      # My AJT fork / harcodes databases to .local/share/Anki2/
      # so the addon can be installed in the Nix store
      (pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
        pname = "AJT Japanese";
        version = "v25.5.15.0";
        src = pkgs.fetchFromGitHub {
          owner = "jdy4k";
          repo = "Japanese-nixos";
          rev = "e0991213d68ccb7616a2c02d57888b944ad44ecf";
          hash = "sha256-Rp05Ko2Kg1kUKCX5DgHbasyJ4349t4L+WzkA+yoRCg0=";
          fetchSubmodules = true;
        };
        sourceRoot = "${finalAttrs.src.name}/japanese";
      }))
    ];
  };
}
