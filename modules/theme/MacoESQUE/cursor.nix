{ pkgs, config, ...}:
{
  home.packages = with pkgs; [
    whitesur-cursors
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "WhiteSur-cursors";
    XCURSOR_SIZE = 24;
  };

}
