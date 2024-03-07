import 'package:flutter/material.dart';
import 'src/pages/home.dart';
import 'src/pages/settings/settings_controller.dart';
import 'src/pages/settings/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settingsController = SettingsController(SettingsService());
  await settingsController.loadSettings();
  runApp(Home(settingsController: settingsController));
}
