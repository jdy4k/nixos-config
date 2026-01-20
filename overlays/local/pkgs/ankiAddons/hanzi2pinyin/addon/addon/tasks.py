# ==================================================================
# addon/tasks.py
# ==================================================================
# Handles automatic pinyin and audio generation
# Based on the Japanese plugin's task system
# ==================================================================
import enum
import logging
import re
from typing import Optional

import anki.collection
from anki.notes import Note
from anki.decks import DeckId
from anki import hooks
from anki.utils import strip_html_media
from aqt import mw

from .components.ruby_processor import RubyProcessor
from .audio import fetch_audio_for_text

log = logging.getLogger(__name__)


@enum.unique
class TaskCaller(enum.Flag):
    """Different contexts that can trigger pinyin generation"""
    focus_lost = enum.auto()
    toolbar_button = enum.auto()
    note_added = enum.auto()
    bulk_add = enum.auto()

    @classmethod
    def all_enabled(cls):
        """Return a flag with all callers enabled"""
        flag = cls(0)
        for item in cls:
            flag |= item
        return flag


class PinyinTask:
    """Represents a pinyin generation task"""
    def __init__(self, source_field: str, dest_field: str, triggered_by: TaskCaller):
        self.source_field = source_field
        self.dest_field = dest_field
        self.triggered_by = triggered_by
    
    @property
    def is_in_place(self) -> bool:
        """Check if this is an in-place transformation (source == dest)"""
        return self.source_field == self.dest_field
    
    def applies_to_note(self, note: Note) -> bool:
        """Check if this task applies to the given note"""
        return (
            self.source_field in note 
            and self.dest_field in note
        )
    
    def should_answer_to(self, caller: TaskCaller) -> bool:
        """Check if this task should run for the given caller"""
        return caller in self.triggered_by


class AudioTask:
    """Represents an audio generation task"""
    def __init__(self, source_field: str, dest_field: str, triggered_by: TaskCaller):
        self.source_field = source_field
        self.dest_field = dest_field
        self.triggered_by = triggered_by
    
    def applies_to_note(self, note: Note) -> bool:
        """Check if this task applies to the given note"""
        return (
            self.source_field in note 
            and self.dest_field in note
        )
    
    def should_answer_to(self, caller: TaskCaller) -> bool:
        """Check if this task should run for the given caller"""
        return caller in self.triggered_by


def get_pinyin_tasks() -> list[PinyinTask]:
    """Get list of pinyin generation tasks"""
    # Generate for various common field name patterns
    # Triggered by all callers (focus_lost, note_added, bulk_add, toolbar_button)
    triggered_by = TaskCaller.all_enabled()
    
    return [
        # Standard Rikaitan/Yomichan field names (source -> destination)
        PinyinTask("Expression", "ExpressionPinyin", triggered_by),
        PinyinTask("Sentence", "SentencePinyin", triggered_by),
        # In-place transformation (when source and dest are the same field)
        # This handles note types where Chinese is stored directly in *Pinyin fields
        PinyinTask("ExpressionPinyin", "ExpressionPinyin", triggered_by),
        PinyinTask("SentencePinyin", "SentencePinyin", triggered_by),
        # Alternative field names (common in Chinese learning decks)
        PinyinTask("Hanzi", "Pinyin", triggered_by),
        PinyinTask("Word", "WordPinyin", triggered_by),
        PinyinTask("Chinese", "ChinesePinyin", triggered_by),
        PinyinTask("Front", "FrontPinyin", triggered_by),
    ]


def get_audio_tasks() -> list[AudioTask]:
    """Get list of audio generation tasks"""
    # Audio generation for word/expression fields only (not sentences)
    # Triggered by all callers
    triggered_by = TaskCaller.all_enabled()
    
    return [
        # Standard field names - fetch audio for expression/word only
        AudioTask("Expression", "ExpressionAudio", triggered_by),
        AudioTask("ExpressionPinyin", "ExpressionAudio", triggered_by),
        # Alternative field names
        AudioTask("Hanzi", "Audio", triggered_by),
        AudioTask("Word", "WordAudio", triggered_by),
        AudioTask("Chinese", "ChineseAudio", triggered_by),
        AudioTask("Front", "FrontAudio", triggered_by),
    ]


def html_to_media_line(txt: str) -> str:
    """Strip HTML but keep media filenames."""
    return strip_html_media(
        txt.replace("<br>", " ")
        .replace("<br/>", " ")
        .replace("<br />", " ")
        .replace("<div>", " ")
        .replace("</div>", " ")
        .replace("\n", " ")
    ).strip()


class DoTasks:
    """Handles automatic pinyin generation for notes"""
    
    def __init__(
        self, 
        note: Note, 
        *, 
        caller: TaskCaller, 
        src_field: Optional[str] = None, 
        overwrite: bool = False
    ):
        self._note = note
        self._caller = caller
        self._src_field = src_field
        self._overwrite = overwrite
    
    def run(self, changed: bool = False) -> bool:
        """Run all applicable pinyin and audio generation tasks"""
        print(f"[Hanzi2Pinyin] DoTasks.run() called with caller={self._caller}")
        print(f"[Hanzi2Pinyin] Note fields: {list(self._note.keys())}")
        
        # Run pinyin tasks
        for task in get_pinyin_tasks():
            print(f"[Hanzi2Pinyin] Checking pinyin task: {task.source_field} -> {task.dest_field}")
            
            # If src_field is specified, only process that field
            if self._src_field and task.source_field != self._src_field:
                print(f"[Hanzi2Pinyin]   Skipped: src_field filter ({self._src_field})")
                continue
            
            applies = task.applies_to_note(self._note)
            answers = task.should_answer_to(self._caller)
            print(f"[Hanzi2Pinyin]   applies_to_note={applies}, should_answer_to={answers}")
            
            if answers and applies:
                print(f"[Hanzi2Pinyin]   Running pinyin task...")
                if self._do_pinyin_task(task):
                    changed = True
            else:
                if not applies:
                    print(f"[Hanzi2Pinyin]   Missing fields: src={task.source_field in self._note}, dest={task.dest_field in self._note}")
        
        # Run audio tasks
        for task in get_audio_tasks():
            print(f"[Hanzi2Pinyin] Checking audio task: {task.source_field} -> {task.dest_field}")
            
            # If src_field is specified, only process that field
            if self._src_field and task.source_field != self._src_field:
                continue
            
            applies = task.applies_to_note(self._note)
            answers = task.should_answer_to(self._caller)
            print(f"[Hanzi2Pinyin]   applies_to_note={applies}, should_answer_to={answers}")
            
            if answers and applies:
                print(f"[Hanzi2Pinyin]   Running audio task...")
                if self._do_audio_task(task):
                    changed = True
        
        return changed
    
    def _do_pinyin_task(self, task: PinyinTask) -> bool:
        """Execute a single pinyin generation task"""
        changed = False
        
        # Get source text and strip HTML/media
        src_text = self._get_source_text(task.source_field)
        dest_text = self._note[task.dest_field]
        
        print(f"[Hanzi2Pinyin] _do_pinyin_task: {task.source_field} -> {task.dest_field} (in_place={task.is_in_place})")
        print(f"[Hanzi2Pinyin] src_text='{src_text[:50] if src_text else ''}...'")
        print(f"[Hanzi2Pinyin] dest_text empty={not dest_text}")
        
        # For in-place transformations, check if already has ruby notation
        if task.is_in_place:
            # Skip if already has ruby notation (contains [pinyin] brackets)
            if src_text and '[' in src_text and ']' in src_text:
                print(f"[Hanzi2Pinyin] Skipped: already has ruby notation")
                return False
            can_process = bool(src_text) and (self._overwrite or not self._has_ruby_notation(src_text))
            print(f"[Hanzi2Pinyin] In-place can_process={can_process}")
        else:
            can_process = self._can_fill_destination(dest_text) and bool(src_text)
            print(f"[Hanzi2Pinyin] can_fill={self._can_fill_destination(dest_text)}")
        
        # Check if we can/should process
        if can_process:
            try:
                # Generate pinyin with ruby notation (classmethod)
                print(f"[Hanzi2Pinyin] Calling RubyProcessor.add_ruby_notation...")
                generated_pinyin = RubyProcessor.add_ruby_notation(src_text)
                print(f"[Hanzi2Pinyin] generated_pinyin='{generated_pinyin[:50] if generated_pinyin else ''}...'")
                
                # Only update if we got valid output and it's different
                if generated_pinyin and generated_pinyin != src_text:
                    self._note[task.dest_field] = generated_pinyin
                    changed = True
                    print(f"[Hanzi2Pinyin] Updated field {task.dest_field}")
                else:
                    print(f"[Hanzi2Pinyin] No change: same as source or empty")
            except Exception as e:
                print(f"[Hanzi2Pinyin] Error generating pinyin: {e}")
                import traceback
                traceback.print_exc()
        else:
            print(f"[Hanzi2Pinyin] Skipped: can_process={can_process}, has_src={bool(src_text)}")
        
        return changed
    
    def _do_audio_task(self, task: AudioTask) -> bool:
        """Execute a single audio generation task"""
        changed = False
        
        # Get source text (Chinese word/expression)
        src_text = self._get_source_text(task.source_field)
        dest_text = self._note[task.dest_field]
        
        print(f"[Hanzi2Pinyin] _do_audio_task: {task.source_field} -> {task.dest_field}")
        print(f"[Hanzi2Pinyin] src_text='{src_text[:30] if src_text else ''}...'")
        
        # Check if destination already has audio
        if not self._overwrite and dest_text and '[sound:' in dest_text:
            print(f"[Hanzi2Pinyin] Skipped: audio already exists")
            return False
        
        # Check if we can fill destination
        can_process = self._can_fill_destination(dest_text) and bool(src_text)
        
        if can_process:
            try:
                # Strip ruby notation from source to get clean Chinese text
                clean_text = re.sub(r'\[[^\]]+\]', '', src_text).strip()
                
                print(f"[Hanzi2Pinyin] Fetching audio for: {clean_text}")
                audio_tag = fetch_audio_for_text(clean_text, overwrite=self._overwrite)
                
                if audio_tag:
                    self._note[task.dest_field] = audio_tag
                    changed = True
                    print(f"[Hanzi2Pinyin] Added audio: {audio_tag}")
                else:
                    print(f"[Hanzi2Pinyin] No audio found for: {clean_text}")
            except Exception as e:
                print(f"[Hanzi2Pinyin] Error fetching audio: {e}")
                import traceback
                traceback.print_exc()
        else:
            print(f"[Hanzi2Pinyin] Skipped audio: can_process={can_process}")
        
        return changed
    
    def _has_ruby_notation(self, text: str) -> bool:
        """Check if text already has ruby notation (Chinese char followed by [pinyin])"""
        import re
        # Pattern: Chinese character followed by [something]
        pattern = r'[\u4e00-\u9fff]\[[^\]]+\]'
        return bool(re.search(pattern, text))
    
    def _can_fill_destination(self, dest_text: str) -> bool:
        """
        The add-on can fill the destination field if it's empty
        or if the user wants to fill it with new data and erase the old data.
        """
        return self._overwrite or not html_to_media_line(dest_text)
    
    def _get_source_text(self, field_name: str) -> str:
        """
        Return source text with sound and image tags removed.
        """
        if field_name not in self._note:
            return ""
        
        field_content = self._note[field_name]
        if not field_content:
            return ""
        
        # Strip media tags (sound/image) using Anki's media strip if available
        if mw and mw.col and mw.col.media:
            try:
                return mw.col.media.strip(field_content).strip()
            except Exception:
                pass
        # Fallback to basic HTML stripping
        return html_to_media_line(field_content)


def on_focus_lost(changed: bool, note: Note, field_idx: int) -> bool:
    """Called when a field loses focus - generate pinyin for that field"""
    return DoTasks(
        note=note,
        caller=TaskCaller.focus_lost,
        src_field=note.keys()[field_idx],
    ).run(changed=changed)


def should_generate(note: Note) -> bool:
    """Generate when a new note is added by AnkiConnect or similar (Rikaitan, etc.)"""
    if not mw:
        return False
    # Generate if no active window (AnkiConnect) AND note.id == 0 (new note being added)
    # This matches the Japanese addon's behavior
    return mw.app.activeWindow() is None and note.id == 0


def on_add_note(_col: anki.collection.Collection, note: Note, _deck_id: DeckId) -> None:
    """Called when a note is added - generate pinyin automatically"""
    print(f"[Hanzi2Pinyin] on_add_note called")
    print(f"[Hanzi2Pinyin] note.id={note.id}")
    print(f"[Hanzi2Pinyin] note fields: {list(note.keys())}")
    print(f"[Hanzi2Pinyin] activeWindow={mw.app.activeWindow() if mw else None}")
    print(f"[Hanzi2Pinyin] should_generate={should_generate(note)}")
    
    # Always try to generate for debugging
    print(f"[Hanzi2Pinyin] Attempting pinyin generation...")
    changed = DoTasks(
        note=note,
        caller=TaskCaller.note_added,
    ).run()
    print(f"[Hanzi2Pinyin] Generation result: changed={changed}")


def init():
    """Initialize automatic pinyin generation hooks"""
    from aqt import gui_hooks
    
    # Generate when editing a note (field loses focus)
    gui_hooks.editor_did_unfocus_field.append(on_focus_lost)
    
    # Generate when AnkiConnect (Rikaitan, etc.) adds a new note.
    hooks.note_will_be_added.append(on_add_note)
    
    log.info("[Hanzi2Pinyin] Automatic pinyin generation initialized")
