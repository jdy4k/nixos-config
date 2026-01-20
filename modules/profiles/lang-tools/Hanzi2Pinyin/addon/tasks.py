# ==================================================================
# addon/tasks.py
# ==================================================================
# Handles automatic pinyin generation for ExpressionPinyin and SentencePinyin fields
# Based on the Japanese plugin's task system
# ==================================================================
import logging
from typing import Optional
from enum import Flag

from anki.notes import Note
from anki.decks import DeckId
from anki import hooks
from aqt import mw

from .components.ruby_processor import RubyProcessor

log = logging.getLogger(__name__)


class TaskCaller(Flag):
    """Different contexts that can trigger pinyin generation"""
    focus_lost = 1
    toolbar_button = 2
    note_added = 4
    bulk_add = 8


class PinyinTask:
    """Represents a pinyin generation task"""
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
    # Generate for Expression -> ExpressionPinyin and Sentence -> SentencePinyin
    # Triggered by focus_lost, note_added, and bulk_add
    triggered_by = TaskCaller.focus_lost | TaskCaller.note_added | TaskCaller.bulk_add
    
    return [
        PinyinTask("Expression", "ExpressionPinyin", triggered_by),
        PinyinTask("Sentence", "SentencePinyin", triggered_by),
    ]


def strip_html_media(txt: str) -> str:
    """Strip HTML but keep media filenames"""
    if not txt:
        return ""
    # Simple stripping - remove HTML tags but keep content
    import re
    # Remove common HTML tags
    txt = re.sub(r'<br\s*/?>', ' ', txt, flags=re.IGNORECASE)
    txt = re.sub(r'<div[^>]*>', ' ', txt, flags=re.IGNORECASE)
    txt = re.sub(r'</div>', ' ', txt, flags=re.IGNORECASE)
    txt = txt.replace('\n', ' ').strip()
    return txt


class DoPinyinTasks:
    """Handles automatic pinyin generation for notes"""
    
    def __init__(self, note: Note, caller: TaskCaller, src_field: Optional[str] = None, overwrite: bool = False):
        self.note = note
        self.caller = caller
        self.src_field = src_field
        self.overwrite = overwrite
        self.processor = RubyProcessor()
    
    def run(self, changed: bool = False) -> bool:
        """Run all applicable pinyin generation tasks"""
        for task in get_pinyin_tasks():
            # If src_field is specified, only process that field
            if self.src_field and task.source_field != self.src_field:
                continue
            
            if task.should_answer_to(self.caller) and task.applies_to_note(self.note):
                if self._do_task(task):
                    changed = True
        return changed
    
    def _do_task(self, task: PinyinTask) -> bool:
        """Execute a single pinyin generation task"""
        changed = False
        
        # Get source text and strip HTML/media
        src_text = self._get_source_text(task.source_field)
        
        # Get destination text
        dest_text = self.note[task.dest_field]
        
        # Check if we can/should fill the destination
        if self._can_fill_destination(task, dest_text) and src_text:
            # Generate pinyin with ruby notation
            generated_pinyin = self.processor.add_ruby_notation(src_text)
            
            # Only update if we got valid output
            if generated_pinyin and generated_pinyin != src_text:
                self.note[task.dest_field] = generated_pinyin
                changed = True
        
        return changed
    
    def _can_fill_destination(self, task: PinyinTask, dest_text: str) -> bool:
        """Check if we can fill the destination field"""
        # Can fill if overwrite is permitted or if destination is empty
        if self.overwrite:
            return True
        
        # Strip HTML/media to check if field is effectively empty
        stripped = strip_html_media(dest_text)
        return not stripped
    
    def _get_source_text(self, field_name: str) -> str:
        """Get source text from field, stripping HTML and media"""
        if field_name not in self.note:
            return ""
        
        field_content = self.note[field_name]
        if not field_content:
            return ""
        
        # Strip media tags (sound/image) using Anki's media strip if available
        if mw and hasattr(mw.col.media, 'strip'):
            try:
                text = mw.col.media.strip(field_content).strip()
            except:
                text = strip_html_media(field_content)
        else:
            text = strip_html_media(field_content)
        
        return text


def on_focus_lost(changed: bool, note: Note, field_idx: int) -> bool:
    """Called when a field loses focus - generate pinyin for that field"""
    if not note:
        return changed
    
    # Get the field name that lost focus
    field_name = note.keys()[field_idx]
    
    # Generate pinyin for the corresponding pinyin field
    # Anki will automatically save the note if we return True
    tasks = DoPinyinTasks(
        note=note,
        caller=TaskCaller.focus_lost,
        src_field=field_name,
    )
    return tasks.run(changed=changed)


def should_generate(note: Note) -> bool:
    """Generate when a new note is added by AnkiConnect or similar"""
    if not mw:
        return False
    # Generate if note was just added (id == 0) and no window is active
    return mw.app.activeWindow() is None and note.id == 0


def on_add_note(_col, note: Note, _deck_id: DeckId) -> None:
    """Called when a note is added - generate pinyin automatically"""
    if should_generate(note):
        tasks = DoPinyinTasks(
            note=note,
            caller=TaskCaller.note_added,
        )
        # Note will be saved automatically by Anki after this hook
        tasks.run()


def init():
    """Initialize automatic pinyin generation hooks"""
    from aqt import gui_hooks
    
    # Generate when editing a note (field loses focus)
    gui_hooks.editor_did_unfocus_field.append(on_focus_lost)
    
    # Generate when a new note is added (AnkiConnect, etc.)
    hooks.note_will_be_added.append(on_add_note)
    
    log.info("[Hanzi2Pinyin] Automatic pinyin generation initialized")

