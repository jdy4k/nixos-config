# ==================================================================
# addon/bulk_add.py
# ==================================================================
# Bulk pinyin generation for selected notes in Anki Browser
# Based on the Japanese plugin's bulk_add system
# ==================================================================
import logging
from collections.abc import Sequence

from anki.collection import Collection, OpChanges
from anki.notes import Note, NoteId
from aqt import mw
from aqt.browser import Browser
from aqt.operations import CollectionOp
from aqt.qt import QAction, qconnect
from aqt.utils import showInfo, tooltip

from .tasks import DoTasks, TaskCaller

log = logging.getLogger(__name__)

ADDON_NAME = "Hanzi2Pinyin"
ACTION_NAME = f"{ADDON_NAME}: Bulk-generate Pinyin & Audio"


def update_notes_op(col: Collection, nids: Sequence[NoteId], overwrite: bool = False) -> OpChanges:
    """Update notes with generated pinyin readings."""
    print(f"[Hanzi2Pinyin] update_notes_op called with {len(nids)} notes, overwrite={overwrite}")
    pos = col.add_custom_undo_entry(f"{ADDON_NAME}: Add pinyin to {len(nids)} notes.")
    to_update = []
    processed = 0
    
    for nid in nids:
        try:
            note = col.get_note(nid)
            print(f"[Hanzi2Pinyin] Processing note {nid}, fields: {list(note.keys())}")
            changed = DoTasks(note=note, caller=TaskCaller.bulk_add, overwrite=overwrite).run()
            print(f"[Hanzi2Pinyin] Note {nid} changed={changed}")
            if changed:
                to_update.append(note)
            processed += 1
        except Exception as e:
            print(f"[Hanzi2Pinyin] Error processing note {nid}: {e}")
            import traceback
            traceback.print_exc()
    
    print(f"[Hanzi2Pinyin] Bulk processed {processed} notes, {len(to_update)} changed")
    
    if to_update:
        col.update_notes(to_update)
    
    return col.merge_undo_entries(pos)


def bulk_add_readings(nids: Sequence[NoteId], parent: Browser) -> None:
    """Run bulk pinyin generation on selected notes."""
    if not nids:
        tooltip("No notes selected")
        return
    
    log.info(f"[Hanzi2Pinyin] Starting bulk generation for {len(nids)} notes")
    
    CollectionOp(
        parent=parent,
        op=lambda col: update_notes_op(col, nids, overwrite=False),
    ).success(
        lambda out: showInfo(
            parent=parent,
            title="Pinyin & Audio Generation Complete",
            textFormat="rich",
            text=f"Processed {len(nids)} selected notes (pinyin + audio).",
        )
    ).run_in_background()


def bulk_add_readings_overwrite(nids: Sequence[NoteId], parent: Browser) -> None:
    """Run bulk pinyin and audio generation on selected notes, overwriting existing data."""
    if not nids:
        tooltip("No notes selected")
        return
    
    log.info(f"[Hanzi2Pinyin] Starting bulk generation (overwrite) for {len(nids)} notes")
    
    CollectionOp(
        parent=parent,
        op=lambda col: update_notes_op(col, nids, overwrite=True),
    ).success(
        lambda out: showInfo(
            parent=parent,
            title="Pinyin & Audio Generation Complete",
            textFormat="rich",
            text=f"Processed {len(nids)} selected notes (overwrite mode).",
        )
    ).run_in_background()


def setup_browser_menu(browser: Browser):
    """Add menu entries to browser window"""
    # Regular bulk add (skip existing)
    action = QAction(ACTION_NAME, browser)
    qconnect(action.triggered, lambda: bulk_add_readings(browser.selectedNotes(), parent=browser))
    browser.form.menuEdit.addAction(action)
    
    # Bulk add with overwrite
    action_overwrite = QAction(f"{ACTION_NAME} (Overwrite)", browser)
    qconnect(action_overwrite.triggered, lambda: bulk_add_readings_overwrite(browser.selectedNotes(), parent=browser))
    browser.form.menuEdit.addAction(action_overwrite)


def init():
    """Initialize bulk add menu in browser."""
    from aqt import gui_hooks
    
    gui_hooks.browser_menus_did_init.append(setup_browser_menu)
    log.info("[Hanzi2Pinyin] Bulk add menu initialized")
