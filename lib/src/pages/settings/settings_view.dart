import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'settings_controller.dart';
import '../notes/note_saving.dart';


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
          //Export All Notes - from zip?
          //Import Notes - from zip?
        ],
      ),
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
