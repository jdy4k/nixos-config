{ username, config, pkgs, ... }:
{  
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "~/Music/";
    settings = {
      lyrics_directory = "~/Music/";
    };
  };
}
