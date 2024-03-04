import 'package:flutter/material.dart';
import '../notes/note.dart';

class NotesList extends ChangeNotifier {
  final List<Note> _notes = [
    Note(1, "Tda", "Udelej tda", DateTime.now()),
    Note(2, "Rimacom", "Udelej rimacom stranku", DateTime.now()),
    Note(3, "Cestina", "Udelej ctenarsky denik o bylo nas pet", DateTime.now())
  ]; 

  List<Note> get notes => _notes;

  void addNote(String title, DateTime date, String body) {
    int lastid = _notes.isNotEmpty ? _notes.last.id : 0;
    _notes.add(Note(lastid+1, title, body, date));
    notifyListeners();
  }
  void removeNote(int id) {
   _notes.removeAt(id-1);
    notifyListeners();
  }
  void editNote(int id, String? title, DateTime? date, String? body) {
    title ??= _notes[id-1].name;
    date ??= _notes[id-1].date;
    body ??= _notes[id-1].detail;
    _notes[id-1] = Note(id, title, body, date);
    notifyListeners();
  }
}