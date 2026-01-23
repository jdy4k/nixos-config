{ pkgs, ... }: 
{
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      autosubsync-mpv
      uosc
    ];
  };
  xdg.configFile."mpv/mpv.conf".source = ./_conf/mpv.conf;
  xdg.configFile."mpv/script-opts".source = ./_conf/script-opts;
}
