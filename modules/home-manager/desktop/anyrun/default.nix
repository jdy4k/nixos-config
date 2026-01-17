{ pkgs, ... }:
{
  imports = [ ./theme.nix ];

  home.packages = with pkgs; [ anyrun ];
  programs.anyrun = {
    enable = true;
    config = {
      y = { fraction = 0.1; };

      plugins = [
        "${pkgs.anyrun}/lib/libapplications.so"
        "${pkgs.anyrun}/lib/librandr.so"
      ];
    };
  };
}

