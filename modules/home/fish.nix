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
      starship init fish | source

      function starship_transient_prompt_func
	      tput cuu1
	      starship module character
      end

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
