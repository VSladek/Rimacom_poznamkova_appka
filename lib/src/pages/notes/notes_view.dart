import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../notes/note_create.dart';
import '../notes/note_list.dart';
import '../settings/settings_view.dart';
import 'note_detail.dart';

class NoteView extends StatefulWidget {
  const NoteView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    final noteList = Provider.of<NotesList>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return NewNote(onNoteCreated: noteList.addNote);
            },
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          size: 37,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        restorationId: 'NotesList',
        itemCount: noteList.notes.length,
        itemBuilder: (BuildContext context, int index) {
          final note = noteList.notes[index];
          return ListTile(
              title: Text(note.title),
              leading: Text('${index+1}:', style: const TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.restorablePushNamed(
                  context,
                  NoteDetail.routeName,
                  arguments: index,
                );
              });
        },
      ),
    );
  }
}
