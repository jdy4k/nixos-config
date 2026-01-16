{ username, config, pkgs, ... }:
{  
  programs.ncmpcpp = {
    enable = true;
    mpdMusicDir = "~/Media/Music/";
    settings = {
      lyrics_directory = "~/Media/Music/";
    };
  };
}
