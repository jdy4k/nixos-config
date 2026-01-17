{ username, config, pkgs, ... }:
{
  home.packages = with pkgs; [
    mpc
    rmpc
    alsa-utils
  ];

  services.mpd = {
    enable = true;
    musicDirectory = "/home/${username}/Media/Music";
    playlistDirectory = "/home/${username}/.local/share/mpd/playlists";
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
