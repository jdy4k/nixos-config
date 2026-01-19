# hanzi2pinyin.nix - NixOS derivation for Hanzi2Pinyin Anki addon
{ pkgs, lib, ... }:

pkgs.anki-utils.buildAnkiAddon (finalAttrs: {
  pname = "Hanzi2Pinyin";
  version = "2025.09.22";

  src = pkgs.fetchFromGitHub {
    owner = "alyssabedard";
    repo = "Hanzi2Pinyin";
    rev = "v${finalAttrs.version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # Replace with actual hash
  };

  # The addon code is in the 'addon' subdirectory
  sourceRoot = "${finalAttrs.src.name}/addon";

  nativeBuildInputs = with pkgs; [
    zip
    python3
  ];

  # Python dependencies required by the addon
  propagatedBuildInputs = with pkgs.python3Packages; [
    jieba
    pypinyin
  ];

  # Custom build phase to handle dependencies
  preBuild = ''
    # Clean up any existing __pycache__ directories
    find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    find . -type f -name "*.pyc" -delete 2>/dev/null || true
    
    # Install Python dependencies to lib/ directory
    # This mimics what the Makefile does with: pip install -r requirements.txt --target ./addon/lib
    mkdir -p lib
    
    # Copy jieba package
    cp -r ${pkgs.python3Packages.jieba}/${pkgs.python3.sitePackages}/jieba lib/
    
    # Copy pypinyin package  
    cp -r ${pkgs.python3Packages.pypinyin}/${pkgs.python3.sitePackages}/pypinyin lib/
    
    # Also copy any dependencies these packages need
    ${lib.optionalString (pkgs.python3Packages.jieba.propagatedBuildInputs != []) ''
      ${lib.concatMapStringsSep "\n" (dep: ''
        if [ -d "${dep}/${pkgs.python3.sitePackages}" ]; then
          for pkg in "${dep}/${pkgs.python3.sitePackages}"/*; do
            if [ -d "$pkg" ] && [ "$(basename "$pkg")" != "__pycache__" ]; then
              cp -r "$pkg" lib/ 2>/dev/null || true
            fi
          done
        fi
      '') pkgs.python3Packages.jieba.propagatedBuildInputs}
    ''}
    
    ${lib.optionalString (pkgs.python3Packages.pypinyin.propagatedBuildInputs != []) ''
      ${lib.concatMapStringsSep "\n" (dep: ''
        if [ -d "${dep}/${pkgs.python3.sitePackages}" ]; then
          for pkg in "${dep}/${pkgs.python3.sitePackages}"/*; do
            if [ -d "$pkg" ] && [ "$(basename "$pkg")" != "__pycache__" ]; then
              cp -r "$pkg" lib/ 2>/dev/null || true
            fi
          done
        fi
      '') pkgs.python3Packages.pypinyin.propagatedBuildInputs}
    ''}
    
    # Clean up any __pycache__ that might have been copied
    find lib -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    find lib -type f -name "*.pyc" -delete 2>/dev/null || true
  '';

  # The buildAnkiAddon function handles the actual packaging
  # No need to override buildPhase unless we need custom behavior

  meta = with lib; {
    description = "Anki add-on that adds Pinyin and Zhuyin readings above Chinese characters";
    longDescription = ''
      This Anki add-on lets you add Pinyin and Zhuyin readings above Chinese 
      characters (Hanzi) in any field. It works by converting your Chinese text 
      into ruby annotations, where the Pinyin appears as small text above the 
      original characters, making it easier to read and study Chinese text.
      
      Features:
      - Pinyin support (Browse and Add editor dialogs)
      - Zhuyin (Bopomofo) support
      - Works with any field name
      - Supports both Simplified and Traditional Chinese
    '';
    homepage = "https://github.com/alyssabedard/Hanzi2Pinyin";
    changelog = "https://github.com/alyssabedard/Hanzi2Pinyin/blob/master/CHANGELOG.md";
    license = licenses.mit;
    maintainers = with maintainers; [ ]; # Add your name here
    platforms = platforms.all;
  };
})
