{
  self,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  nixpkgs.overlays = [
    inputs.nix-firefox-addons.overlays.default
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];

  # Font packages
  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.font-awesome

    pkgs.noto-fonts
    pkgs.noto-fonts-cjk-sans
    pkgs.noto-fonts-cjk-serif
    pkgs.liberation_ttf
    pkgs.takao
    pkgs.ipaexfont

    inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
  ];

  time.timeZone = lib.mkDefault "America/New_York";
  system.stateVersion = "25.11";

}
