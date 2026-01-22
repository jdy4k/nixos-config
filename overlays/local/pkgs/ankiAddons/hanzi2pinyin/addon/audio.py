# ==================================================================
# addon/audio.py
# ==================================================================
# Audio fetching for Chinese words
# Uses Forvo or other free audio sources
# ==================================================================
import hashlib
import os
import re
import urllib.request
import urllib.parse
from typing import Optional, List
from pathlib import Path

from aqt import mw

# Audio source URLs (free sources)
FORVO_URL = "https://apifree.forvo.com/key/{api_key}/format/json/action/word-pronunciations/word/{word}/language/zh"
GOOGLE_TTS_URL = "https://translate.google.com/translate_tts?ie=UTF-8&client=tw-ob&tl=zh-CN&q={word}"


def get_media_dir() -> Optional[Path]:
    """Get Anki's media directory."""
    if mw and mw.col:
        return Path(mw.col.media.dir())
    return None


def sanitize_filename(word: str) -> str:
    """Create a safe filename from the word."""
    # Remove any characters that aren't safe for filenames
    safe = re.sub(r'[^\w\u4e00-\u9fff-]', '', word)
    return f"hanzi2pinyin_{safe}.mp3"


def file_exists_in_media(filename: str) -> bool:
    """Check if file already exists in Anki's media folder."""
    media_dir = get_media_dir()
    if media_dir:
        return (media_dir / filename).exists()
    return False


def format_audio_tag(filename: str) -> str:
    """Create Anki's [sound:filename] tag."""
    return f"[sound:{filename}]"


def download_audio_google_tts(word: str) -> Optional[bytes]:
    """
    Download audio using Google Translate TTS.
    Note: This is for personal/educational use only.
    """
    try:
        encoded_word = urllib.parse.quote(word)
        url = GOOGLE_TTS_URL.format(word=encoded_word)
        
        headers = {
            'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36',
            'Referer': 'https://translate.google.com/',
        }
        
        req = urllib.request.Request(url, headers=headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            return response.read()
    except Exception as e:
        print(f"[Hanzi2Pinyin] Error downloading audio: {e}")
        return None


def save_audio_to_media(data: bytes, filename: str) -> bool:
    """Save audio data to Anki's media folder."""
    if not mw or not mw.col:
        return False
    
    try:
        # Use Anki's media API to save the file
        mw.col.media.write_data(filename, data)
        return True
    except Exception as e:
        print(f"[Hanzi2Pinyin] Error saving audio: {e}")
        return False


def fetch_audio_for_word(word: str, overwrite: bool = False) -> Optional[str]:
    """
    Fetch audio for a Chinese word and save to media folder.
    Returns the [sound:filename] tag if successful, None otherwise.
    """
    if not word or not any('\u4e00' <= c <= '\u9fff' for c in word):
        # No Chinese characters
        return None
    
    filename = sanitize_filename(word)
    
    # Check if already exists
    if not overwrite and file_exists_in_media(filename):
        print(f"[Hanzi2Pinyin] Audio already exists: {filename}")
        return format_audio_tag(filename)
    
    # Try to download
    print(f"[Hanzi2Pinyin] Downloading audio for: {word}")
    audio_data = download_audio_google_tts(word)
    
    if audio_data and save_audio_to_media(audio_data, filename):
        print(f"[Hanzi2Pinyin] Saved audio: {filename}")
        return format_audio_tag(filename)
    
    return None


def fetch_audio_for_text(text: str, overwrite: bool = False) -> Optional[str]:
    """
    Fetch audio for Chinese text.
    For longer text, only fetches audio for the first word/phrase.
    """
    # Strip HTML and whitespace
    clean_text = re.sub(r'<[^>]+>', '', text).strip()
    
    # Remove any existing ruby notation
    clean_text = re.sub(r'\[[^\]]+\]', '', clean_text)
    
    if not clean_text:
        return None
    
    # For very long text, just use the first few characters
    if len(clean_text) > 10:
        # Try to find a natural break point
        clean_text = clean_text[:10]
    
    return fetch_audio_for_word(clean_text, overwrite=overwrite)

