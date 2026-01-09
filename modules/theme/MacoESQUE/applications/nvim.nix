{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
    };
    plugins = {
      transparent.enable = true;      
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
