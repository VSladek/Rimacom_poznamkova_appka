import 'package:flutter/material.dart';
import 'src/pages/home.dart';
import 'src/pages/settings/settings_controller.dart';
import 'src/pages/settings/settings_service.dart';
import 'src/pages/notes/note_list.dart';


void main() async {
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(Home(settingsController: settingsController));
}
