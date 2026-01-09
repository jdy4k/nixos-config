{ pkgs, inputs, lib, username, myconfig, ... }: let

  bg = pkgs.runCommand "bg.jpg" { } ''
    cp ${./../../assets/sddm-bg.jpg} $out
  '';
  avatar = "${./../../assets/avatar.jpg}";

  sddm-theme =
    inputs.silentSDDM.packages.${pkgs.system}.default.override 
      (if myconfig.theme == "MacoESQUE" then
         (import ./../theme/MacoESQUE/sddm.nix { inherit bg avatar myconfig; })
       else if myconfig.theme == "TrueAMOLED" then
         (import ./../theme/TrueAMOLED/sddm.nix { inherit bg avatar myconfig; })
       else
         { });

in {
  environment.systemPackages = [sddm-theme sddm-theme.test];
  qt.enable = true;
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    enable = true;

    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs ++ [ pkgs.xorg.xrandr pkgs.kdePackages.layer-shell-qt ];
    setupScript = ''
      ${pkgs.xorg.xrandr}/bin/xrandr --output HDMI-1 --off
      ${pkgs.xorg.xrandr}/bin/xrandr --output DP-3 --off
    '';
   };

  systemd.tmpfiles.rules =
    let
      user = "${username}";
      iconPath = avatar;
    in
    [
      "f+ /var/lib/AccountsService/users/${user}  0600 root root -  [User]\\nIcon=/var/lib/AccountsService/icons/${user}\\n"
      "L+ /var/lib/AccountsService/icons/${user}  -    -    -    -  ${iconPath}"
    ];
}
