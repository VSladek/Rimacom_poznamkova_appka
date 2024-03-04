import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NewNote extends StatefulWidget {
  final void Function(String title, DateTime date, String body) onNoteCreated;

  const NewNote({Key? key, required this.onNoteCreated}) : super(key: key);
  
  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {

  final _formKey = GlobalKey<FormState>();
  late DateTime _date;
  late String _title;
  late String _body;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(AppLocalizations.of(context)!.new_note),
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
                autocorrect: true,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              const SizedBox(height: 24,),
              InputDatePickerFormField(
                keyboardType: TextInputType.datetime,
                fieldHintText: "dd.mm.yyyy",
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3648)),
                onDateSaved: (value) {
                  _date = value;
                },
              ),
              TextFormField(
                decoration:  InputDecoration(
                  labelText: AppLocalizations.of(context)!.body,
                ),
                autocorrect: true,
                onSaved: (value) {
                  _body = value!;
                },
              ),
              const SizedBox(height: 24,),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    widget.onNoteCreated(_title, _date, _body);
                    Navigator.pop(context);
                  }
                },
                child: Text(AppLocalizations.of(context)!.create),
              ),
            ],
          ),
        ),
      )]
    );
  }
}