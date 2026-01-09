{ pkgs, ... }: 
{
  programs.zathura = {
    enable = true;
    package = (pkgs.zathura.override { plugins = with pkgs.zathuraPkgs; [ zathura_pdf_mupdf ]; });
    extraConfig = ''
      # zathurarc-light
      set notification-error-bg       "#000000" # base2  # seem not work
      set notification-error-fg       "#6c71c4" # red
      set notification-warning-bg     "#000000" # base2
      set notification-warning-fg     "#b58900" # red
      set notification-bg             "#000000" # base2
      set notification-fg             "#d33682" # mag
      
      set completion-bg               "#fdf6e3" # base3
      set completion-fg               "#657b83" # base00
      set completion-group-bg         "#eee8d5" # base2
      set completion-group-fg         "#586e75" # base01
      set completion-highlight-bg     "#93a1a1" # base1
      set completion-highlight-fg     "#073642" # base02
      
      # Define the color in index mode
      set index-bg                   "#fdf6e3" # base3
      set index-fg                   "#657b83" # base00
      set index-active-bg             "#eee8d5" # base2
      set index-active-fg             "#586e75" # base01
      
      set inputbar-bg                 "#000000" # base1
      set inputbar-fg                 "#ffffff" # base02
      
      set statusbar-bg                "#000000" # base3
      set statusbar-fg                "#ffffff" # base00
      
      set highlight-fg	         "rgba(211, 54, 130, 0.45)"
      set highlight-color	         "rgba(211, 54, 130, 0.45)" 
      set highlight-active-color	 "rgba(211, 54, 130, 0.45)"
      
      set default-bg                  "#fdf6e3" # base3
      set default-fg                  "#657b83" # base00
      set render-loading              true
      # set render-loading-fg           "#fdf6e3" # base3
      # set render-loading-bg           "#fdf6e3" # base3
      
      # Recolor book content's color
      # verbose
      # verbose
      set recolor-lightcolor          "#fdf6e3" # base3
      set recolor-darkcolor           "#000000" # base00
      set recolor                     "true"
      # set recolor-keephue             true      # keep original color
      
      set selection-notification false
      '';
  };
}
