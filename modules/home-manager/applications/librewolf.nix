{ pkgs, lib, inputs, ... }:
let
  profile = "default";
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
        bitwarden-password-manager
        sidebery
        userchrome-toggle-extended
      ]
      ++ (with pkgs.local.firefoxAddons; [
        rikaitan
      ]);
    };
  };

  home.file.".librewolf/${profile}/chrome" = {
    source = "${inputs.potatofox}/chrome";
    recursive = true;
  };
}
