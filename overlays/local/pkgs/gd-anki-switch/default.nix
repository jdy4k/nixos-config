{ pkgs }:
pkgs.writers.writePython3Bin "gd-anki-switch"
  {
    libraries = with pkgs.python3Packages; [
    ];
    makeWrapperArgs = [
      "--prefix PATH : ${pkgs.lib.makeBinPath [
        pkgs.procps
        pkgs.wl-clipboard
        pkgs.goldendict-ng
      ]}"
    ];
  }
''
import sys
import subprocess
import xml.etree.ElementTree as ET
from pathlib import Path

CONFIG_PATH = Path.home() / ".config/goldendict/config"

PROFILES = {
    "Chinese": {
        "deck": "Chinese",
        "model": "Chinese sentences",
        "text": "Definition",
        "word": "ExpressionPinyin",
        "sentence": "SentencePinyin"
    },
    "Japanese": {
        "deck": "Japanese",
        "model": "Japanese sentences",
        "text": "VocabDef",
        "word": "VocabKanji",
        "sentence": "SentKanji"
    }
}


def get_current_language():
    """Read the current language from GoldenDict config."""
    try:
        tree = ET.parse(CONFIG_PATH)
        root = tree.getroot()

        anki_server = root.find('.//ankiConnectServer')
        if anki_server is None:
            return "Chinese"

        deck = anki_server.find('deck')
        if deck is not None and deck.text == "Chinese":
            return "Chinese"
        elif deck is not None and deck.text == "Japanese":
            return "Japanese"
        return "Chinese"
    except Exception as e:
        print(f"Error reading config: {e}", file=sys.stderr)
        return "Chinese"


def kill_goldendict():
    """Kill all GoldenDict processes."""
    import time
    try:
        # Try multiple process names
        for proc_name in ['goldendict-ng', 'goldendict']:
            subprocess.run(
                ['pkill', '-9', proc_name],
                stderr=subprocess.DEVNULL,
                check=False
            )
        # Wait for processes to actually terminate
        time.sleep(1)
        return True
    except Exception as e:
        print(f"Error killing GoldenDict: {e}", file=sys.stderr)
        return False


def update_config(language):
    """Update the GoldenDict config with the specified language profile."""
    try:
        tree = ET.parse(CONFIG_PATH)
        root = tree.getroot()

        anki_server = root.find('.//ankiConnectServer')
        if anki_server is None:
            return False

        profile = PROFILES[language]

        for key, value in profile.items():
            elem = anki_server.find(key)
            if elem is not None:
                elem.text = value

        tree.write(CONFIG_PATH, encoding='utf-8', xml_declaration=True)
        return True
    except Exception as e:
        print(f"Error updating config: {e}", file=sys.stderr)
        return False


def start_goldendict():
    """Start GoldenDict."""
    try:

        clipboard = subprocess.run(
            ['wl-paste'],
            capture_output=True,
            text=True,
            check=False
        ).stdout.strip()

        subprocess.Popen(
            ['goldendict', clipboard],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            start_new_session=True
        )
        return True
    except Exception as e:
        print(f"Error starting GoldenDict: {e}", file=sys.stderr)
        return False


def toggle_language():
    """Toggle between Chinese and Japanese."""
    current = get_current_language()
    new_lang = "Japanese" if current == "Chinese" else "Chinese"

    kill_goldendict()
    update_config(new_lang)
    start_goldendict()

    return new_lang


def main():
    if len(sys.argv) > 1:
        if sys.argv[1] == "toggle":
            new_lang = toggle_language()
            print(f"Switched to {new_lang}")
        elif sys.argv[1] == "server":
            # Run a simple HTTP server for handling toggle requests
            from http.server import HTTPServer, BaseHTTPRequestHandler

            class ToggleHandler(BaseHTTPRequestHandler):
                def do_GET(self):
                    if self.path == '/toggle':
                        toggle_language()
                        self.send_response(200)
                        self.send_header('Content-type', 'text/html')
                        self.end_headers()
                        self.wfile.write(
                            b'<html><body>Switched! Close this window.'
                            b'</body></html>'
                        )
                    else:
                        self.send_response(404)
                        self.end_headers()

                def log_message(self, format, *args):
                    pass  # Suppress log messages

            server = HTTPServer(('127.0.0.1', 8989), ToggleHandler)
            print("Server running on http://127.0.0.1:8989")
            server.serve_forever()
    else:
        # Return HTML for display in GoldenDict
        current = get_current_language()
        is_chinese = current == "Chinese"

        active_cn = "active" if is_chinese else ""
        active_jp = "active" if not is_chinese else ""
        disabled_cn = "disabled" if is_chinese else ""
        disabled_jp = "disabled" if not is_chinese else ""

        html = (
            '<style>'
            '#gdfrom-7dafc8f7728626da94520be92baefcca { '
            'height: 0px !important; '
            'overflow: hidden !important; '
            '}'
            '#gdfrom-7dafc8f7728626da94520be92baefcca * '
            '{ display: none !important; }'
            '#gdfrom-7dafc8f7728626da94520be92baefcca '
            '+ div[style*="clear"] + .gdarticleseparator '
            '{ display: none !important; }'
            '#gdfrom-5e22b90de9e7abf6186769f89222460d .ankibutton, '
            '#gdfrom-e63f1e57f6f7ceee7531b7593ee0968a .ankibutton '
            '{ display: none !important; }'
            '#gdfrom-5e22b90de9e7abf6186769f89222460d .gddictname, '
            '#gdfrom-e63f1e57f6f7ceee7531b7593ee0968a .gddictname '
            '{ position: relative; }'
            '.lang-switch { '
            'position: absolute; '
            'top: 35px; '
            'right: 8px; '
            'display: flex; '
            'border: 1px solid #ccc; '
            'border-radius: 4px; '
            'overflow: hidden; '
            'height: 20px; '
            'font-size: 11px; '
            'z-index: 1000; '
            '}'
            '.lang-btn { '
            'padding: 2px 6px; '
            'border: none; '
            'cursor: pointer; '
            'background: #f5f5f5; '
            'color: #666; '
            'transition: all 0.2s; '
            '}'
            '.lang-btn.active { '
            'background: #2196F3; '
            'color: white; '
            'font-weight: bold; '
            '}'
            '</style>'
            '<script>'
            'document.addEventListener("DOMContentLoaded", function() {'
            'var targets = ['
            '"gddictname-5e22b90de9e7abf6186769f89222460d", '
            '"gddictname-e63f1e57f6f7ceee7531b7593ee0968a"'
            '];'
            'targets.forEach(function(targetId) {'
            'var elem = document.getElementById(targetId);'
            'if (elem) {'
            'var switchDiv = document.createElement("div");'
            'switchDiv.className = "lang-switch";'
            'switchDiv.innerHTML = '
            f'"<button class=\\"lang-btn {active_cn}\\" '
            'onclick=\\"'
            'var img=new Image(); '
            "img.src='http://127.0.0.1:8989/toggle'; "
            'setTimeout(function(){location.reload();}, 1500);\\" '
            f'{disabled_cn}>'
            '🇨🇳'
            '</button>'
            f'<button class=\\"lang-btn {active_jp}\\" '
            'onclick=\\"'
            'var img=new Image(); '
            "img.src='http://127.0.0.1:8989/toggle'; "
            'setTimeout(function(){location.reload();}, 1500);\\" '
            f'{disabled_jp}>'
            '🇯🇵'
            '</button>";'
            'elem.appendChild(switchDiv);'
            '}'
            '});'
            '});'
            '</script>'
        )
        print(html)


if __name__ == '__main__':
    main()
''
