# ==================================================================
# addon/bulk_add.py
# ==================================================================
# Handles bulk pinyin generation for multiple notes in the browser
# Based on the Japanese plugin's bulk_add.py
# ==================================================================
from collections.abc import Sequence
from typing import TYPE_CHECKING

from anki.collection import Collection, OpChanges
from anki.notes import Note, NoteId
from aqt import mw
from aqt.browser import Browser
from aqt.operations import CollectionOp
from aqt.qt import *
from aqt.utils import showInfo

from .tasks import DoPinyinTasks, TaskCaller

if TYPE_CHECKING:
    from aqt.browser import Browser


ACTION_NAME = "Bulk-add pinyin"


def update_notes_op(col: Collection, notes: Sequence[Note]) -> OpChanges:
    """Update multiple notes with pinyin generation"""
    pos = col.add_custom_undo_entry(f"Hanzi2Pinyin: Add pinyin to {len(notes)} notes.")
    to_update = []
    for note in notes:
        tasks = DoPinyinTasks(note=note, caller=TaskCaller.bulk_add)
        changed = tasks.run()
        if changed:
            to_update.append(note)
    
    if to_update:
        col.update_notes(to_update)
    
    return col.merge_undo_entries(pos)


def bulk_add_pinyin(nids: Sequence[NoteId], parent: Browser) -> None:
    """Bulk add pinyin to selected notes"""
    if not nids:
        showInfo(
            parent=parent,
            title="No notes selected",
            textFormat="rich",
            text="Please select one or more notes in the browser first.",
        )
        return
    
    CollectionOp(
        parent=parent,
        op=lambda col: update_notes_op(col, notes=[mw.col.get_note(nid) for nid in nids]),
    ).success(
        lambda out: showInfo(
            parent=parent,
            title="Pinyin generation complete",
            textFormat="rich",
            text=f"Processed {len(nids)} note(s).",
        )
    ).run_in_background()


def setup_browser_menu(browser: Browser) -> None:
    """Add menu entry to browser window"""
    action = QAction(ACTION_NAME, browser)
    qconnect(action.triggered, lambda: bulk_add_pinyin(browser.selectedNotes(), parent=browser))
    browser.form.menuEdit.addAction(action)


def init():
    """Initialize bulk add menu"""
    from aqt import gui_hooks
    
    gui_hooks.browser_menus_did_init.append(setup_browser_menu)

