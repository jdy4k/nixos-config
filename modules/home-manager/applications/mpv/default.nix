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
  xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
  xdg.configFile."mpv/script-opts".source = ./script-opts;
}
