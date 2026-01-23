{ pkgs, config, ... }:
{
  programs.lf = {
    settings = {
      cleaner = "${config.xdg.configHome}/lf/bin/cleaner";
      previewer = "${config.xdg.configHome}/lf/bin/previewer";
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
