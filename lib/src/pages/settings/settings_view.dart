import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'settings_controller.dart';
import '../notes/note_saving.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import '../notes/note_list.dart';
import 'package:flutter/foundation.dart' as WebPlatform;


class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.controller});

  static const routeName = 'settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Column(
        children: [
          ThemeSetting(controller: controller),
          LanguageSetting(controller: controller),
          FileSetting(controller: controller),
          const SizedBox(height: 2,),
          const FileDownload(),
          const SizedBox(height: 10,),
          const FileUpload(),
        ],
      ),
    );
  }
}

class FileDownload extends StatelessWidget {
  const FileDownload({super.key});

  @override
  Widget build(BuildContext context) {
    final noteList = Provider.of<NotesList>(context, listen: true);
    return Row(
      children: [
        const SizedBox(width: 16),
        ElevatedButton(onPressed: () async {
          try {
            String? outputFile;
            if (WebPlatform.kIsWeb) { 
              await noteList.downloadNotes(outputFile, context, web: true);
              }
            else if (Platform.isAndroid || Platform.isIOS){
              outputFile = await FilePicker.platform.getDirectoryPath(
                dialogTitle: 'Please select where to download file:',
              );
              //print(outputFile);
              }
            else {
                outputFile = await FilePicker.platform.saveFile(
                  dialogTitle: 'Please select where to download file:',
                  fileName: 'notes.json',
                );
              }
              //print(outputFile);
              if (outputFile != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Downloading notes...')),
                );

                await noteList.downloadNotes(outputFile, context);

            }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
              );
            }
        }, 
        child: Text(AppLocalizations.of(context)!.export))
      ],
    );
  }
}

class FileUpload extends StatelessWidget {
  const FileUpload({super.key});

  @override
  Widget build(BuildContext context) {
    final noteList = Provider.of<NotesList>(context, listen: false);

    return Row(
      children: [
        const SizedBox(width: 16),
        ElevatedButton(onPressed: () async {
            try {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['json'],
              );
              //print(result.toString());
              if (result != null) {
                  PlatformFile file = result.files.first;
                  //print(file.name);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Importing notes...')),
                  );
                  //print(file.path);
                if (!WebPlatform.kIsWeb) {
                  await noteList.importNotes(file, context);
                  await FilePicker.platform.clearTemporaryFiles();
                } else {
                  await noteList.importNotes(file, context, web: true);
                }

              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Error: File is empty')),
                );
                return;
              }
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $e')),
              );
            }
          },
          child: Text(AppLocalizations.of(context)!.import),
        ),
      ],
    );
  }
}



class FileSetting extends StatelessWidget {
  const FileSetting({
    super.key,
    required this.controller,
  });

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(AppLocalizations.of(context)!.format),
        const SizedBox(width: 10),
        DropdownButton<NoteSaveFormat>(
          value: controller.format,
          onChanged: controller.updateFormat,
          items:  [
            DropdownMenuItem(
              value: const NoteSaveFormat('json'),
              child: Text(AppLocalizations.of(context)!.format_json),
            ),
            DropdownMenuItem(
              enabled: false,
              value: const NoteSaveFormat('txt'),
              child: Text(AppLocalizations.of(context)!.format_txt),
            ),
          ],
        ),
      ],
    );
  }
}

class LanguageSetting extends StatelessWidget {
  const LanguageSetting({
    super.key,
    required this.controller,
  });

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(AppLocalizations.of(context)!.language),
        const SizedBox(width: 10),
        DropdownButton<Locale>(
          value: controller.localization,
          onChanged: controller.updateLocalization,
          items: const [
            DropdownMenuItem(
              value: Locale('cs'),
              child: Text("Čeština"),
            ),
            DropdownMenuItem(
              value: Locale('en'),
              child: Text("English"),
            ),
          ],
        ),
      ],
    );
  }
}

class ThemeSetting extends StatelessWidget {
  const ThemeSetting({
    super.key,
    required this.controller,
  });

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        Text(AppLocalizations.of(context)!.theme),
        const SizedBox(width: 10),
        DropdownButton<ThemeMode>(
          value: controller.themeMode,
          onChanged: controller.updateThemeMode,
          items:  [
            DropdownMenuItem(
              value: ThemeMode.system,
              child: Text(AppLocalizations.of(context)!.system_theme),
            ),
            DropdownMenuItem(
              value: ThemeMode.light,
              child: Text(AppLocalizations.of(context)!.light_theme),
            ),
            DropdownMenuItem(
              value: ThemeMode.dark,
              child: Text(AppLocalizations.of(context)!.dark_theme),
            )
          ],
        ),
      ],
    );
  }
}
