import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../notes/note_list.dart';
import 'note.dart';

class NoteDetail extends StatelessWidget {
  const NoteDetail({super.key, required this.note});

  static const routeName = 'note';
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(AppLocalizations.of(context)!.date),
                const SizedBox(
                  width: 6,
                ),
                Text(note.date.toLocal().toString()),
              ],
            ),
            Text(note.detail,
                style: const TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          onPressed: () {
            final noteList = Provider.of<NotesList>(context, listen: false);
            noteList.editNote(note.id,"Changed title",null,null);
          },
          backgroundColor: Colors.blue[400],
          child: const Icon(
            Icons.edit,
            size: 37,
            color: Colors.white,
          ),
        ),
        FloatingActionButton(
          onPressed: () {
            final noteList = Provider.of<NotesList>(context, listen: false);
            noteList.removeNote(note.id);
          },
          backgroundColor: Colors.blue[400],
          child: const Icon(
            Icons.delete,
            size: 37,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
