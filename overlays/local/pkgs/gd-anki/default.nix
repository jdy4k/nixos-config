{ pkgs }:

pkgs.writers.writePython3Bin "tesseract-ocr" 
  #{
  #  libraries = with pkgs.python3Packages; [ 
  #  ];
  #  makeWrapperArgs = [
  #    "--prefix PATH : ${pkgs.lib.makeBinPath [ 
  #    ]}"
  #  ];
  #}
  ''
  #!/usr/bin/env python3
  """
  GoldenDict Anki Connect Toggle Script
  Toggles between two different Anki Connect configurations
  """
  
  import xml.etree.ElementTree as ET
  import sys
  import os
  
  # Configuration State 1
  STATE_1 = {
      'enabled': '1',
      'host': '127.0.0.1',
      'port': '8765',
      'deck': 'Bank',
      'model': 'Japanese sentences',
      'text': 'VocabDeff',
      'word': 'VocabKanji',
      'sentence': 'SentKanji'
  }
  
  # Configuration State 2
  STATE_2 = {
      'enabled': '1',
      'host': '127.0.0.1',
      'port': '8765',
      'deck': 'Study',
      'model': 'Basic',
      'text': 'Definition',
      'word': 'Word',
      'sentence': 'Example'
  }
  
  def get_config_path():
      """Get the GoldenDict config file path based on OS"""
      home = os.path.expanduser("~")
      
      if sys.platform == "win32":
          config_path = os.path.join(home, "AppData", "Roaming", "GoldenDict", "config")
      elif sys.platform == "darwin":
          config_path = os.path.join(home, "Library", "Preferences", "GoldenDict", "config")
      else:  # Linux
          config_path = os.path.join(home, ".goldendict", "config")
      
      return config_path
  
  def find_anki_section(root):
      """Find the ankiConnectServer element in the XML tree"""
      # Try different possible paths
      anki_section = root.find('.//ankiConnectServer')
      if anki_section is None:
          anki_section = root.find('ankiConnectServer')
      return anki_section
  
  def get_current_state(anki_section):
      """Determine which state the config is currently in"""
      if anki_section is None:
          return None
      
      current_deck = anki_section.find('deck')
      if current_deck is not None and current_deck.text == STATE_1['deck']:
          return 1
      return 2
  
  def update_anki_section(anki_section, state_config):
      """Update the ankiConnectServer section with new values"""
      anki_section.set('enabled', state_config['enabled'])
      
      for key, value in state_config.items():
          if key == 'enabled':
              continue
          
          element = anki_section.find(key)
          if element is not None:
              element.text = value
          else:
              # Create element if it doesn't exist
              new_element = ET.SubElement(anki_section, key)
              new_element.text = value
  
  def toggle_config(config_path=None):
      """Toggle between the two configuration states"""
      if config_path is None:
          config_path = get_config_path()
      
      if not os.path.exists(config_path):
          print(f"Error: Config file not found at {config_path}")
          print("Please specify the correct path as an argument.")
          return False
      
      try:
          # Parse the XML file
          tree = ET.parse(config_path)
          root = tree.getroot()
          
          # Find the ankiConnectServer section
          anki_section = find_anki_section(root)
          
          if anki_section is None:
              print("Error: ankiConnectServer section not found in config file")
              return False
          
          # Determine current state and toggle
          current_state = get_current_state(anki_section)
          
          if current_state == 1:
              new_state = STATE_2
              new_state_num = 2
          else:
              new_state = STATE_1
              new_state_num = 1
          
          # Update the configuration
          update_anki_section(anki_section, new_state)
          
          # Write back to file with proper formatting
          tree.write(config_path, encoding='utf-8', xml_declaration=True)
          
          print(f"✓ Toggled to State {new_state_num}")
          print(f"  Deck: {new_state['deck']}")
          print(f"  Model: {new_state['model']}")
          
          return True
          
      except ET.ParseError as e:
          print(f"Error parsing XML: {e}")
          return False
      except Exception as e:
          print(f"Error: {e}")
          return False
  
  def show_current_state(config_path=None):
      """Display the current configuration state"""
      if config_path is None:
          config_path = get_config_path()
      
      if not os.path.exists(config_path):
          print(f"Error: Config file not found at {config_path}")
          return
      
      try:
          tree = ET.parse(config_path)
          root = tree.getroot()
          anki_section = find_anki_section(root)
          
          if anki_section is None:
              print("ankiConnectServer section not found")
              return
          
          print("Current Anki Connect Configuration:")
          print(f"  Enabled: {anki_section.get('enabled', 'N/A')}")
          for key in ['host', 'port', 'deck', 'model', 'text', 'word', 'sentence']:
              element = anki_section.find(key)
              value = element.text if element is not None else 'N/A'
              print(f"  {key.capitalize()}: {value}")
          
          current_state = get_current_state(anki_section)
          print(f"\n  Current State: {current_state if current_state else 'Unknown'}")
          
      except Exception as e:
          print(f"Error: {e}")
  
  if __name__ == "__main__":
      if len(sys.argv) > 1:
          if sys.argv[1] in ['-s', '--show', 'show']:
              show_current_state(sys.argv[2] if len(sys.argv) > 2 else None)
          elif sys.argv[1] in ['-h', '--help', 'help']:
              print("Usage:")
              print("  python anki_toggle.py [config_path]     - Toggle configuration")
              print("  python anki_toggle.py -s [config_path]  - Show current state")
              print("  python anki_toggle.py -h                - Show this help")
          else:
              toggle_config(sys.argv[1])
      else:
          toggle_config()
  ''
