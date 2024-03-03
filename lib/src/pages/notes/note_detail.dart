import 'package:flutter/material.dart';
import 'note.dart';

class NoteDetail extends StatelessWidget {
  const NoteDetail({super.key,required this.note});

  static const routeName = 'note';
  final Note note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(note.name),
      ),
      body: Center(
        child: Text(note.detail),
      ),
    );
  }
}
