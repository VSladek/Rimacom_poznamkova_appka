import 'package:flutter/material.dart';
import 'note.dart';

class NoteDetail extends StatelessWidget {
  const NoteDetail({super.key});

  static const routeName = 'note';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: Text('More Information Here'),
      ),
    );
  }
}
