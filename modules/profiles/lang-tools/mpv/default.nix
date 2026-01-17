{ pkgs, ... }: 
{
  programs.mpv = {
    scripts = with pkgs.mpvScripts; [
      mpvacious
    ];
  };
  xdg.configFile."mpv/script-opts/subs2srs.conf".source = ./conf/script-opts/subs2srs.conf;
}
