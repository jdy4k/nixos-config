{ 
  pkgs, 
  inputs,
  username, 
  ...
}: let

  bg = pkgs.runCommand "bg.jpg" { } ''
    cp ${./../../../assets/sddm-bg.jpg} $out
  '';

  avatar = "${./../../../assets/avatar.jpg}";
  
  sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.override {
    theme = "default";
    extraBackgrounds = [
      bg
    ];
    # https://github.com/uiriansan/SilentSDDM/wiki/Options/
    theme-overrides = {
      "General" = {
        scale = "1.0";
        padding-top = 100;
        background-fill-mode = "fill";
      };
      "LoginScreen" = {
        background = "${bg.name}";
      };
      "LockScreen" = {
        background = "${bg.name}";
      };
      "LockScreen.Clock" = {
        font-family = "SFProDisplay Nerd Font SemiBold";
        font-size = 140;
        font-weight = 0;
      };
      "LockScreen.Date" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 30;
        font-weight = 0;
      };
      "LockScreen.Message" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "LoginScreen.LoginArea.Username" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "LoginScreen.LoginArea.PasswordInput" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 10;
        font-weight = 0;
      };
      "LoginScreen.LoginArea.LoginButton" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "LoginScreen.LoginArea.Spinner" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "LoginScreen.LoginArea.WarningMessage" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "LoginScreen.MenuArea.Buttons" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "LoginScreen.MenuArea.Popups" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
      "Tooltips" = {
        font-family = "SFProDisplay Nerd Font Medium";
        font-size = 20;
        font-weight = 0;
      };
    };
  };

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
