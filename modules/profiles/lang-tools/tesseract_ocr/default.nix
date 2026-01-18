{ config, pkgs, ... }:

let
  tesseract-ocr = pkgs.writeShellApplication {
    name = "tesseract-ocr";
    
    runtimeInputs = with pkgs; [
      python3
      python313Packages.pytesseract
      python313Packages.pillow
      (tesseract.override {
        enableLanguages = [ "jpn" "eng" ];
      })
      wl-clipboard
    ];
    
    text = ''
      python3 ${pkgs.writeText "tesseract_ocr.py" ''
        #!/usr/bin/env python3
        from PIL import Image
        import pytesseract
        import subprocess
        import io
        
        result = subprocess.run(
            ['wl-paste', '--type', 'image/png'],
            capture_output=True,
            check=True
        )
        
        img = Image.open(io.BytesIO(result.stdout))
        text = pytesseract.image_to_string(img, lang='jpn+eng')
        print(text)
      ''}
    '';
  };
in
{
  environment.systemPackages = [
    tesseract-ocr
  ];
}
