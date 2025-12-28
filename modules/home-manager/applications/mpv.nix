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
}
