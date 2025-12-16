{ pkgs, inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  home.shellAliases.v = "nvim";

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    nixpkgs.useGlobalPackages = true;
    viAlias = true;
    vimAlias = true;

    plugins = {
      treesitter = {
        enable = true;
				autoLoad = true;
      };
      web-devicons.enable = true;
      cursorline.enable = true;
      smear-cursor.enable = true;
      neoscroll.enable = true;
      telescope.enable = true;
      undotree.enable = true;
    };

    opts = {
      number = true;
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };

    highlight = {
      Normal = {
        bg = "none";
      };
      NormalFloat = {
        bg = "none";
      };
      NormalNC = {
        bg = "none";
      };
      WinSeparator = {
        bg = "none";
      };
      WinBar = {
        bg = "none";
      };
      SignColumn = {
        bg = "none";
      };
      StatusLine = {
        bg = "none";
      };
      Pmenu = {
        bg = "none";
      };
      CursorLine = {
        bg = "none";
      };
    };
  };
}
