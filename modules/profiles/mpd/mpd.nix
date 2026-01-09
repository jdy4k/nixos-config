{ username, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mpc
    rmpc
    alsa-utils
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/${username}/Music";
    playlistDirectory = "/home/${username}/.playlists";
    extraConfig = ''
      restore_paused "yes"
      auto_update "yes"

      audio_output {
        type "pipewire"
        name "pipewire"
      }
    '';
  };
}
