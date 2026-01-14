{ pkgs, inputs, ... }:
{
  programs.nixvim = {
    colorschemes.tokyonight = {
      enable = true;
    };
    plugins = {
      transparent = {
        enable = true;
        settings = {
          extra_groups = [
            "NormalFloat"
            "NvimTreeNormal"
          ];
        };
      };      
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
