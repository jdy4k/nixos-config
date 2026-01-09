{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.shellAliases.v = "nvim";
  home.packages = with pkgs; [
    ripgrep
    fzf
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;
    viAlias = true;
    vimAlias = true;

    plugins = {
      web-devicons.enable = true;
      cursorline.enable = true;
      smear-cursor.enable = true;
      neoscroll.enable = true;
      telescope.enable = true;
      transparent.enable = true;
      rainbow-delimiters.enable = true;
      mini-pairs.enable = true;
      lualine.enable = true;

      treesitter = {
        enable = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
          folding.enable = true;
        };
      };

      supermaven = { 
        enable = true;
        settings = {
          keymaps = {
            accept_suggestion = "<A-tab>";
          };
        };
      };
    };

    keymaps = [
      {
        action = "<cmd>Telescope find_files<CR>";
        key = "<A-f>";
      }
      {
        action = "<cmd>Telescope live_grep<CR>";
        key = "<A-g>";
      }
    ];

    opts = {
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      syntax = "on";
    };
  };
}
