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

    buildPhase = ''
      g++ -std=c++23 -O2 -c src/rdricpp.cpp -o rdricpp.o -I src
      ar rcs librdricpp.a rdricpp.o
    '';

    installPhase = ''
      mkdir -p $out/include/rdricpp $out/lib
      cp src/*.h $out/include/rdricpp/
      cp librdricpp.a $out/lib/
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
    pkg-config
  ];

  buildInputs = with pkgs; [
    libcpr
    curl
    openssl
    nlohmann_json
    marisa
    mecab
  ];

  buildPhase = ''
    runHook preBuild

    # Compile all source files
    g++ -std=c++23 -O2 \
      -I${cpp-subprocess}/include \
      -I${rdricpp}/include \
      -I${pkgs.nlohmann_json}/include \
      -I${pkgs.marisa}/include \
      -I${pkgs.mecab}/include \
      -I${pkgs.libcpr}/include \
      -D_GLIBCXX_ASSERTIONS \
      -o gd-tools \
      src/main.cpp \
      src/anki_search.cpp \
      src/echo.cpp \
      src/images.cpp \
      src/kana_conv.cpp \
      src/marisa_split.cpp \
      src/massif.cpp \
      src/mecab_split.cpp \
      src/translate.cpp \
      src/util.cpp \
      -L${rdricpp}/lib -lrdricpp \
      -L${pkgs.marisa}/lib -lmarisa \
      -L${pkgs.mecab}/lib -lmecab \
      -L${pkgs.libcpr}/lib -lcpr \
      -L${pkgs.curl}/lib -lcurl \
      -pthread

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/share/gd-tools $out/share/fonts/gd-tools

    # Install main binary
    install -Dm755 gd-tools $out/bin/gd-tools

    # Create symlinks for variants
    for variant in gd-ankisearch gd-echo gd-massif gd-images gd-marisa gd-mecab gd-translate; do
      ln -s $out/bin/gd-tools $out/bin/$variant
    done

    # Install shell scripts
    for script in src/*.sh; do
      install -Dm755 "$script" "$out/bin/$(basename $script)"
    done

    # Install resources
    cp res/*.dic $out/share/gd-tools/ 2>/dev/null || true
    cp res/*.ttf $out/share/fonts/gd-tools/ 2>/dev/null || true

    runHook postInstall
  '';

  meta = with lib; {
    description = "A set of tools to enhance GoldenDict for immersion learning";
    homepage = "https://github.com/Ajatt-Tools/gd-tools";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}
