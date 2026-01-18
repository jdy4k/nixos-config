{ pkgs ? import <nixpkgs> {} }:

pkgs.writers.writePython3Bin "tesseract-ocr" 
  {
    libraries = with pkgs.python3Packages; [ 
      pillow 
      pytesseract 
    ];
    makeWrapperArgs = [
      "--prefix PATH : ${pkgs.lib.makeBinPath [ 
        pkgs.tesseract
        pkgs.wl-clipboard 
      ]}"
    ];
  }
  ''
    from PIL import Image
    import pytesseract
    import subprocess
    import io
    
    # Get image from Wayland clipboard
    result = subprocess.run(
        ['wl-paste', '--type', 'image/png'],
        capture_output=True,
        check=True
    )
    
    # Convert to PIL Image
    img = Image.open(io.BytesIO(result.stdout))
    
    # OCR with Japanese and English
    text = pytesseract.image_to_string(img, lang='jpn+eng')
    print(text)
  ''
