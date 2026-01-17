{ pkgs, ... }: 
{
  programs.mpv = {
    scripts = with pkgs.mpvScripts; [
      mpvacious
    ];
  };
  xdg.configFile."mpv/script-opts".source = ./conf/script-opts;
}
