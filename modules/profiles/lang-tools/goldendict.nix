{ pkgs, ... }:

let
  #gd-tools = pkgs.callPackage ./gd-tools.nix { };
  
  gd-clipboard = pkgs.writeShellScript "gd-clipboard" ''
    read -r clipboard 
    
    [ -z "''${clipboard// }" ] && exit 0
    
    #find a better way of doing this that is not hyprland dependent
    if [[ $(hyprctl activewindow | grep class:) == *"goldendict"* ]]; then
      exit 0
    fi

    if echo $clipboard | grep -P '\p{Script=Hiragana}|\p{Script=Katakana}|\p{Script=Han}'; then
      echo "Contains Japanese characters"
    else
      echo "No Japanese characters found"
      exit 0
    fi
    
    if ${pkgs.procps}/bin/pgrep -f goldendict > /dev/null; then
      ${pkgs.goldendict-ng}/bin/goldendict "$clipboard"
    fi
  '';
in
{
  home.packages = with pkgs; [
    goldendict-ng
    mecab
    local.gd-tools
    wl-clipboard
  ];

  #home.file.".local/share/gd-tools/marisa_words.dic".source = 
  #  "${pkgs.local.gd-tools}/share/gd-tools/marisa_words.dic";

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
