{ inputs, lib, ... }:
{
  imports = [ 
    inputs.dms.homeModules.dank-material-shell 
    ./theme.nix
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd = {
      enable = true; # Systemd service for auto-start
      restartIfChanged = true; # Auto-restart dms.service when dankMaterialShell changes
    };

    settings = {
      theme = "dark";
      dynamicTheming = true;
    };

    enableSystemMonitoring = true; # System monitoring widgets (dgop)
    enableVPN = true; # VPN management widget
    enableAudioWavelength = true; # Audio visualizer (cava)
    enableCalendarEvents = true; # Calendar integration (khal)
  };

  xdg.configFile."DankMaterialShell/settings.json".source = lib.mkForce ./_config/settings.json;
}
