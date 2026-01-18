{ writers, python3Packages } :

pkgs.writers.writePython3Bin "tesseract-ocr" 
  {
    libraries = with pkgs.python3Packages; [ 
      pillow 
      pytesseract 
    ];
    makeWrapperArgs = [
      "--prefix PATH : ${pkgs.lib.makeBinPath [ 
        pkgs.tesseract
        pkgs.grim
        pkgs.slurp
        pkgs.wl-clipboard
      ]}"
    ];
  }
  ''
    from PIL import Image
    import pytesseract
    import subprocess
    import io
    
    result = subprocess.run(
        'grim -g "$(slurp -w 0)" -',
        shell=True,
        capture_output=True,
        check=True
    )
    
    # Convert to PIL Image
    img = Image.open(io.BytesIO(result.stdout))
    
    # OCR with Japanese and English
    text = pytesseract.image_to_string(img, lang='jpn+eng')
    subprocess.run(['wl-copy'], input=text, text=True, check=True)
  ''
