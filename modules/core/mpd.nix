{
  username,
  config,
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    mpc
    mpdris2
    rmpc
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
    user = "${username}";
  };
  
  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

}
