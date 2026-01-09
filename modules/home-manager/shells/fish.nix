{ pkgs, ... }:
{
  home.packages = with pkgs; [
    fd
    bat
  ];

  programs.fzf = {
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      bind alt-f "fzf-file-widget ./"
      bind alt-r "fzf-history-widget"
      set -g fish_prompt_invoke_commands 0

      function prompt_newline --on-event fish_postexec
      	echo
      end
      
      alias clear "command clear; commandline -f clear-screen"
    '';
    plugins = [
      {name = "fzf-fish"; src = pkgs.fishPlugins.fzf-fish;}
    ];
  };
}
