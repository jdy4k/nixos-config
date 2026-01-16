{ pkgs, ... }: 
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv;
    scripts = with pkgs.mpvScripts; [
      autosubsync-mpv
      uosc
      mpvacious
    ];
  };
  xdg.configFile."mpv/mpv.conf".source = ./conf/mpv.conf;
  xdg.configFile."mpv/script-opts".source = ./conf/script-opts;
}
