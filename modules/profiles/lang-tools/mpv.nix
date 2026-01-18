{ pkgs, ... }: 
{
  programs.mpv = {
    scripts = with pkgs.mpvScripts; [
      mpvacious
    ];
  };
}
