import 'dart:developer';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:universal_html/html.dart' as universal_html;
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import '../notes/note.dart';
import 'package:file_picker/file_picker.dart';

class NotesList extends ChangeNotifier {
  List<Note> notes = [];
  final String storageKey = 'notes';

  void addNote(String title, String body, DateTime date) {
    notes.add(Note(title, body, date));
    saveNotes();
  }
  void addNotes(List<Note> import) {
    for (int i = 0; i < import.length; i++){
      notes.add(import[i]);
      //print("Note: ${import[i].toString()}");
    }
    saveNotes();
  }

  void removeNote(int index) {
    notes.removeAt(index-1);
    saveNotes();
  }

  void editNote(int id, String? title, String? body, DateTime? date) {
    int index = id-1;
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

  late final File webFile;

  Future<void> downloadNotes(String? path, BuildContext context, {bool web = false}) async {
    // Get json form notes
    String? jsonObject = notes.map((note) => note.toJson()).toList().toString();
    // make it look good
    if (jsonObject.isNotEmpty || notes.isNotEmpty){
      String json = const JsonEncoder.withIndent("     ").convert(jsonObject);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No notes exist.')),
        );
      return;
    }
    if (!web) {
      //print(path);
      // write file to selected path
      File(path!).writeAsString(jsonObject);
      ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notes downloaded successfully.')),
          );
    } else {
      if (notes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No notes exist.')),
        );
      return;
    }
      try {
      const dataType = 'application/json';
      final base64data = base64Encode(utf8.encode(jsonObject));
      final anchorElement = universal_html.AnchorElement(
        href: 'data:$dataType;base64,$base64data',
      )
        ..setAttribute('download', 'notes.json')
        ..click();
    } catch (e) {
      log('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading notes: $e')),
      );
    }
    }
  }

  Future<void> importNotes(PlatformFile file, BuildContext context, {bool web = false}) async {
    try {
      List<dynamic> jsonData;
      if (!web) {
        String? path = file.path; 
        if (path != null) {
          //print("importing: $path");
          File localFile = File(path);

          final jsonString = await localFile.readAsString();
          //print("importing jsonString: $jsonString");

          jsonData = json.decode(jsonString);
          //print("importing jsonData: $jsonData");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: File path is null')),
          );
          return;
        }
      } else {
        if (file.bytes != null) {
          String? jsonString = utf8.decode(file.bytes as List<int>);
          //print(jsonString);
          jsonData = json.decode(jsonString);
          //print(jsonData);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error: File is empty')),
          );
          return;
        }
      }
      List<Note> importedNotes = jsonData.map((data) => Note.fromJson(data)).toList();
      //print("importing adding notes: $importedNotes");
      addNotes(importedNotes);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Notes imported successfully.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error importing notes: $e')),
      );
    }

    //read form json 
    /*[
        {"title":"title 1", "body": "body", "date":"2023-4-8T00:00:00.000"},
        {"title":"title 2", "body": "body", "date":"2023-4-8T00:00:00.000"},
      ] 
    */
  }
}
