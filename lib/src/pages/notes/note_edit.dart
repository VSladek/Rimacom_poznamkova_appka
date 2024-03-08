import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../notes/note_list.dart';


class NoteEdit extends StatefulWidget {
  const NoteEdit({super.key, required this.edit, required this.id});

  final void Function(int id, String? title, String? body, DateTime? date) edit;
  final int id;

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {

  final _formKey = GlobalKey<FormState>();
  late DateTime? _date;
  late String? _title;
  late String? _body;

  @override
  Widget build(BuildContext context) {
    final noteList = Provider.of<NotesList>(context, listen: true);
    return SimpleDialog(
      title: Text(AppLocalizations.of(context)!.edit_note),
      children: [
        Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration:  InputDecoration(
                  labelText: AppLocalizations.of(context)!.title,
                ),
                initialValue: noteList.notes[widget.id].title,
                autocorrect: true,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value;
                },
              ),
              const SizedBox(height: 24,),
              InputDatePickerFormField(
                keyboardType: TextInputType.datetime,
                fieldHintText: "dd.mm.yyyy",
                initialDate: noteList.notes[widget.id].date,
                firstDate: DateTime.now().subtract(const Duration(days: 20000)),
                lastDate: DateTime.now().add(const Duration(days: 20000)),
                acceptEmptyDate: true,
                onDateSaved: (value) {
                  _date = value;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(
                  labelText: AppLocalizations.of(context)!.body,
                ),
                initialValue: noteList.notes[widget.id].body,
                autocorrect: true,
                onSaved: (value) {
                  _body = value;
                },
              ),
              const SizedBox(height: 24,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.edit(widget.id+1, _title, _body, _date);
                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.save),
              ),
            ],
          ),
        ),
      )]
    );
  }
}