{ pkgs, lib, fetchFromGitHub, ... }:

let
  # Header-only subprocess library
  cpp-subprocess = pkgs.stdenv.mkDerivation {
    pname = "cpp-subprocess";
    version = "2024.01.25";

    src = fetchFromGitHub {
      owner = "arun11299";
      repo = "cpp-subprocess";
      rev = "4025693decacaceb9420efedbf4967a04cb028e7";
      hash = "sha256:1fvknb9fdf50a25zf09jmf6i3s5yj63fvq7il6bpzmb1baszq682";
    };

    installPhase = ''
      mkdir -p $out/include
      cp subprocess.hpp $out/include/
    '';
  };

  # Rikaitan deinflector reference implementation
  rdricpp = pkgs.stdenv.mkDerivation {
    pname = "rdricpp";
    version = "0.3";

    src = fetchFromGitHub {
      owner = "Ajatt-Tools";
      repo = "rdricpp";
      rev = "v0.3";
      hash = "sha256:16ra8335rgv97w26bjd3qkdb372rjjf6aa6zjpnd7v8l0dpjis6r";
    };

    nativeBuildInputs = with pkgs; [ xmake pkg-config ];

    buildPhase = ''
      export HOME=$TMPDIR
      xmake config -m release
      xmake build
    '';

    installPhase = ''
      mkdir -p $out/include $out/lib
      cp -r include/* $out/include/ 2>/dev/null || cp *.hpp $out/include/ 2>/dev/null || true
      find . -name "*.a" -exec cp {} $out/lib/ \; 2>/dev/null || true
      find . -name "*.so" -exec cp {} $out/lib/ \; 2>/dev/null || true
    '';
  };

in
pkgs.stdenv.mkDerivation rec {
  pname = "gd-tools";
  version = "unstable-2024";

  src = fetchFromGitHub {
    owner = "Ajatt-Tools";
    repo = "gd-tools";
    rev = "main";
    hash = "sha256:0ikkiy6769wwiahd33rvpjyps0isd9skd1443lv8nfi244mpqbb8";
  };

  nativeBuildInputs = with pkgs; [
    xmake
    pkg-config
    gcc13
  ];

  buildInputs = with pkgs; [
    cpr
    curl
    openssl
    nlohmann_json
    marisa
    mecab
    cpp-subprocess
    rdricpp
  ];

  configurePhase = ''
    export HOME=$TMPDIR
    export PKG_CONFIG_PATH="${pkgs.cpr}/lib/pkgconfig:${pkgs.marisa}/lib/pkgconfig:${pkgs.mecab}/lib/pkgconfig:$PKG_CONFIG_PATH"
    export CPLUS_INCLUDE_PATH="${cpp-subprocess}/include:${rdricpp}/include:${pkgs.nlohmann_json}/include:${pkgs.marisa}/include:${pkgs.mecab}/include:${pkgs.cpr}/include:$CPLUS_INCLUDE_PATH"
    export LIBRARY_PATH="${rdricpp}/lib:${pkgs.marisa}/lib:${pkgs.mecab}/lib:${pkgs.cpr}/lib:$LIBRARY_PATH"
  '';

  buildPhase = ''
    export HOME=$TMPDIR
    xmake config -m release --tests=n
    xmake build -v gd-tools
  '';

  installPhase = ''
    mkdir -p $out/bin $out/share/gd-tools $out/share/fonts/gd-tools

    # Install main binary
    find build -name "gd-tools" -type f -executable -exec cp {} $out/bin/ \;

    # Create symlinks for variants
    for variant in gd-ankisearch gd-echo gd-massif gd-images gd-marisa gd-mecab; do
      ln -s $out/bin/gd-tools $out/bin/$variant
    done

    # Install shell scripts
    for script in src/*.sh; do
      install -Dm755 "$script" "$out/bin/$(basename $script)"
    done

    # Install resources
    cp res/*.dic $out/share/gd-tools/ 2>/dev/null || true
    cp res/*.ttf $out/share/fonts/gd-tools/ 2>/dev/null || true
  '';

  meta = with lib; {
    description = "A set of tools to enhance GoldenDict for immersion learning";
    homepage = "https://github.com/Ajatt-Tools/gd-tools";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}

