import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../settings/settings_view.dart';
import 'note.dart';
import 'note_detail.dart';

class NoteList extends StatelessWidget {
  const NoteList({
    super.key,
    this.items = const [
      Note(1, "Tda", "Udelej tda", 1598746),
      Note(2, "Rimacom", "Udelej rimacom stranku", 1599524),
      Note(3, "Cestina", "Udelej ctenarsky denik o bylo nas pet", 1603458)
    ],
  });

  static const routeName = '/';

  final List<Note> items;

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        restorationId: 'NotesList',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.name),
              leading: Text('${item.id}: '),
              onTap: () {
                Navigator.restorablePushNamed(
                  context,
                  NoteDetail.routeName,
                );
              });
        },
      ),
    );
  }
}
