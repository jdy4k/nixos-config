{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    bat
  ];

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };
  
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      bind alt-f "fzf-file-widget ./"
      bind alt-r "fzf-history-widget"
    '';
    plugins = [
      {name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish;}
    ];
  };
}
