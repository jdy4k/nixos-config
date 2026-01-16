{ buildFirefoxXpiAddon, fetchurl, lib, stdenv }:
{
  rikaitan = buildFirefoxXpiAddon {
    pname = "rikaitan";
    version = "25.12.31.0";
    addonId = "tatsu@autistici.org";
    url = "https://github.com/Ajatt-Tools/rikaitan/releases/download/25.12.31.0/rikaitan-firefox-selfhosted.xpi";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    meta = with stdenv.lib;
    {
      homepage = "https://gitlab.com/KevinRoebert/ClearUrls";
      description = "Remove tracking elements from URLs.";
      license = licenses.lgpl3;
      platforms = platforms.all;
    };
  };
}
