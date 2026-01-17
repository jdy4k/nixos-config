{ pkgs, lib, ... }:
{  
  programs.anki = {
    enable = true;
    minimalistMode = true;

    addons = with pkgs.ankiAddons; [
      anki-connect
      passfail2
      review-heatmap
      
      # My AJT fork / harcodes databases to .local/share/Anki2/
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

      # AJT tries to write to a database in its local directory, which is not possible in the Nix store
      #(pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
      #  pname = "AJT Japanese";
      #  version = "v25.5.15.0";
      #  src = pkgs.fetchFromGitHub {
      #    owner = "Ajatt-Tools";
      #    repo = "Japanese";
      #    rev = "1c993fdb90c771fd5e154bd4e2b57e12a3ca1991";
      #    hash = "sha256-oQ38Gmvwp1dSgrUZA9pz4DAxPrbQDrhsGoi+BSNh3fs=";
      #    fetchSubmodules = true;
      #  };
      #  sourceRoot = "${finalAttrs.src.name}/japanese";
      #}))
    ];
  };
}
