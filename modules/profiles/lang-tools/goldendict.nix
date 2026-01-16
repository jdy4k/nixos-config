{ pkgs, ... }:

let
  gd-tools = pkgs.callPackage ./gd-tools.nix { };
  
  gd-clipboard = pkgs.writeShellScript "gd-clipboard" ''
    read -r clipboard
    
    [ -z "''${clipboard// }" ] && exit 0 
    
    if ${pkgs.procps}/bin/pgrep -f goldendict > /dev/null; then
      ${pkgs.goldendict-ng}/bin/goldendict "$clipboard"
    fi
  '';
in
{
  home.packages = with pkgs; [
    goldendict-ng
    mecab
    gd-tools
    wl-clipboard
  ];

  home.file.".local/share/gd-tools/marisa_words.dic".source = 
    "${gd-tools}/share/gd-tools/marisa_words.dic";

  systemd.user.services.gd-clipboard = {
    Unit = {
      Description = "Send clipboard changes to GoldenDict";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --watch ${gd-clipboard}";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
