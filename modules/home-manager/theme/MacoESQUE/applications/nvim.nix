{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
    };
    plugins = {
      lualine = {
        settings = {
          options = {
            theme = "nord";
          };
        };
      };
    };
  };
}
