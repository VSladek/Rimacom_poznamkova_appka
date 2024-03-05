import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../notes/note.dart';

class NotesList extends ChangeNotifier {
  List<Note> notes = [];
  final String storageKey = 'notes';

  void addNote(String title, String body, DateTime date) {
    notes.add(Note(title, body, date));
    saveNotes();
  }

  void removeNote(int index) {
    notes.removeAt(index);
    saveNotes();
  }

  void editNote(int index, String? title, String? body, DateTime? date) {
    if (index >= 0 && index < notes.length) {
      title ??= notes[index].title;
      body ??= notes[index].body;
      date ??= notes[index].date;
      notes[index] = Note(title, body, date);
      saveNotes();
    }
  }

  Future<void> saveNotes() async {
    final LocalStorage storage = LocalStorage('notes');
    await storage.setItem(
        storageKey, notes.map((note) => note.toJson()).toList());
    notifyListeners();
  }

  Future<void> loadNotes() async {
    final LocalStorage storage = LocalStorage('notes');
    await storage.ready;
    List<dynamic>? jsonList = storage.getItem(storageKey);
    if (jsonList != null && jsonList.isNotEmpty) {
      notes.clear();
      for (var json in jsonList) {
        if (json is Map<String, dynamic>) {
          notes.add(Note.fromJson(json));
        }
      }
      notifyListeners();
    }
  }
}
