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
