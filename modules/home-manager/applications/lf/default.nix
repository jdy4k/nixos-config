{ pkgs, config, ... }:
{
  programs.lf = {
    enable = true;
    settings = {
      cleaner = "${config.xdg.configHome}/lf/_bin/cleaner";
      previewer = "${config.xdg.configHome}/lf/_bin/previewer";
    };
    keybindings = {
      "a" = ":push %touch<space>''<left>";
      "A" = ":push %mkdir<space>''<left>";
      "<delete>" = ":delete";
      "<right>" = ":open";
      "b" = "$vidir";
      "E" = "!atool -x \"$fx\"";
    };
  };

  xdg.configFile."lf/bin/cleaner".source = ./_bin/cleaner;
  xdg.configFile."lf/bin/previewer".source = ./_bin/previewer;

  home.packages = with pkgs; [
    bat
    glow
    atool
    unrar
    unzip
    catdoc
    p7zip
    libcdio
    python313Packages.docx2txt
    exiftool
    ffmpegthumbnailer
    file
    epub-thumbnailer
    wkhtmltopdf
    poppler
    moreutils
  ];
}
