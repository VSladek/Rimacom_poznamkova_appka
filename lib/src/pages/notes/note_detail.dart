import 'package:intl/intl.dart' show DateFormat;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../notes/note_list.dart';
import '../notes/note_edit.dart';

class NoteDetail extends StatefulWidget {
  const NoteDetail({super.key, required this.id});

  static const routeName = 'note';
  final int id;

  @override
  State<NoteDetail> createState() => _NoteDetailState();
}

class _NoteDetailState extends State<NoteDetail> {
  @override
  Widget build(BuildContext context) {
    final noteList = Provider.of<NotesList>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(noteList.notes[widget.id].title),
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
                Text(DateFormat.yMd().format(noteList.notes[widget.id].date.toLocal())),
              ],
            ),
            Text(noteList.notes[widget.id].body,
                style: const TextStyle(
                  fontSize: 20,
                )),
          ],
        ),
      ),
      persistentFooterButtons: [
        FloatingActionButton(
          heroTag: 'edit_${widget.id}',
          onPressed: () {
            setState(() {
              showDialog(
              context: context,
              builder: (BuildContext context) {
                return NoteEdit(id: widget.id, edit: noteList.editNote);
              });
            });
          },
          backgroundColor: Colors.blue[400],
          child: const Icon(
            Icons.edit,
            size: 37,
            color: Colors.white,
          ),
        ),
        FloatingActionButton(
          heroTag: 'delete_${widget.id}',
          onPressed: () {
            setState(() {
              noteList.removeNote(widget.id);
              Navigator.pop(context);
            });
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
