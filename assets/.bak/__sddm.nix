{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    sddm-chili-theme
    xorg.xrandr
  ];

  services.displayManager.sddm = {
    enable = true;
    theme = "chili";
    wayland.enable = true;
    setupScript = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --off
      '';

  };


    #setupScript = ''
    #  echo "=== SDDM Display Debug - $(date) ===" >> /tmp/sddm-display-debug.log
    #  echo "DISPLAY=$DISPLAY" >> /tmp/sddm-display-debug.log
    #  echo "" >> /tmp/sddm-display-debug.log
    #  echo "Available displays in SDDM context:" >> /tmp/sddm-display-debug.log
    #  /home/jdy4k/Downloads/xrandr >> /tmp/sddm-display-debug.log 2>&1
    #  echo "" >> /tmp/sddm-display-debug.log
    #  echo "Full xrandr output:" >> /tmp/sddm-display-debug.log
    #  /home/jdy4k/Downloads/xrandr >> /tmp/sddm-display-debug.log 2>&1
    #  echo "=== Debug finished ===" >> /tmp/sddm-display-debug.log
    #  echo "" >> /tmp/sddm-display-debug.log
    #  '';
}
