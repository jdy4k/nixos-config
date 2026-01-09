{ 
  pkgs, 
  inputs,
  username, 
  ...
}: let

  bg = pkgs.runCommand "bg.jpg" { } ''
    cp ${./../../assets/sddm-bg.jpg} $out
  '';

  avatar = "${./../../assets/avatar.jpg}";
  
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
  }

in {
  environment.systemPackages = [sddm-theme sddm-theme.test];
  qt.enable = true;
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    enable = true;
    wayland.enable = true;
    theme = sddm-theme.pname;
    extraPackages = sddm-theme.propagatedBuildInputs;
    settings = {
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };
    };
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
