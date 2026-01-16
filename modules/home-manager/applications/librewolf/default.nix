{ pkgs, lib, inputs, nur, stdenv, fetchurl, ... }:
let
  profile = "default";

  rikaitan = pkgs.buildFirefoxXpiAddon {
    pname = "rikaitan";
    version = "25.12.31.0";
    addonId = "tatsu@autistici.org";
    url = "https://github.com/Ajatt-Tools/rikaitan/releases/download/25.12.31.0/rikaitan-firefox-selfhosted.xpi";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
in
{
  programs.librewolf = {
    enable = true;
    profiles.${profile} = {
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;
        "layout.css.has-selector.enabled" = true;
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.urlbar.trimURLs" = true;
        "browser.profiles.enabled" = true;
        "widget.gtk.rounded-bottom-corners.enabled" = true;
        "browser.compactmode.show" = true;
        "widget.gtk.ignore-bogus-leave-notify" = 1;
        "browser.tabs.allow_transparent_browser" = true;
        "browser.uidensity" = 1;
        "browser.aboutConfig.showWarning" = false;
        "extensions.autoDisableScopes" = 0;
      };
      extensions.packages = with pkgs.firefoxAddons; [
        pkgs.firefoxAddons.bitwarden-password-manager
        pkgs.firefoxAddons.sidebery
        pkgs.firefoxAddons.userchrome-toggle-extended
        rikaitan
      ];
    };
  };

  import ./generated.nix {
    inherit lib stdenv fetchurl;
    inherit (inputs.nur.repos.rycee.firefox-addons) buildFirefoxXpiAddon;
  }

  home.file.".librewolf/${profile}/chrome" = {
    source = "${inputs.potatofox}/chrome";
    recursive = true;
  };
}
