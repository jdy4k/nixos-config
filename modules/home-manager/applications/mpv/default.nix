{ pkgs, ... }: 
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
    scripts = with pkgs.mpvScripts; [
      autosubsync-mpv
      uosc
    ];
  };
  xdg.configFile."mpv/mpv.conf".source = ./conf/mpv.conf;
  xdg.configFile."mpv/script-opts/uosc.conf".source = ./conf/script-opts/uosc.conf;
}
