{ pkgs, ... }:
{
  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-icons;
    };
    theme = {
      name = "Orchis";
    };
    gtk3.extraConfig = {
      gtk-decoration-layout = "";
    };
    gtk4.extraConfig = {
      gtk-decoration-layout = "";
    };
  };

  xdg.dataFile."themes/Orchis".source = 
    ./../../../assets/gtk-themes/Orchis;
  xdg.configFile."gtk-4.0/gtk.css".source = 
    ./../../../assets/gtk-themes/Orchis/gtk-4.0/gtk.css;
  xdg.configFile."gtk-4.0/gtk-dark.css".source = 
    ./../../../assets/gtk-themes/Orchis/gtk-4.0/gtk-dark.css;
  xdg.configFile."gtk-4.0/assets".source = 
    ./../../../assets/gtk-themes/Orchis/gtk-4.0/assets;
}
