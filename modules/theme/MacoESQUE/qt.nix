{ pkgs, ... }:
{
  qt = {    
    enable = true;
    platformTheme.name = "kde";
    style.name = "kvantum";
  };

  # Install Kvantum
  home.packages = with pkgs; [
    kdePackages.qtstyleplugin-kvantum
  ];

  # Configure Kvantum to use OrchisDark theme
  xdg.configFile."Kvantum/Orchis".source = ./../../../assets/qt-themes/Orchis;

  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=Orchis
  '';
}
