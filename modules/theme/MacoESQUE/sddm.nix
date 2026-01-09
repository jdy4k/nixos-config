{ bg, avatar, myconfig, ... }:
{
  theme = "default";
  extraBackgrounds = [
    bg
  ];
  # https://github.com/uiriansan/SilentSDDM/wiki/Options/
  theme-overrides = {
    "General" = {
      #scale = if ("${myconfig.monitors.primary.resolution.width}" == "3840") then "2.0" else "1.0";
      scale = "1.5";
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
}
