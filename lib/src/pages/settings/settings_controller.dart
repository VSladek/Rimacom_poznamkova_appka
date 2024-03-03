import 'package:flutter/material.dart';
import '../notes/note_saving.dart';
import 'settings_service.dart';

class SettingsController with ChangeNotifier {
  SettingsController(this._settingsService);

  final SettingsService _settingsService;

  late ThemeMode _themeMode;
  late Locale _localization;
  late NoteSaveFormat _format;

  ThemeMode get themeMode => _themeMode;
  Locale get localization => _localization;
  NoteSaveFormat get format => _format;

  Future<void> loadSettings() async {
    _themeMode = await _settingsService.getThemeMode();
    _localization = await _settingsService.getLocalization();
    _format = await _settingsService.getFormat();

    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;
    if (newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    await _settingsService.updateThemeMode(newThemeMode);
  }
  Future<void> updateLocalization(Locale? newLocalization) async {
    if (newLocalization == null) return;
    if (newLocalization == _localization) return;
    _localization = newLocalization;
    notifyListeners();
    await _settingsService.updateLocalization(newLocalization);
  }
  Future<void> updateFormat(NoteSaveFormat? newFormat) async {
    if (newFormat == null) return;
    if (newFormat == _format) return;
    _format = newFormat;
    notifyListeners();
    await _settingsService.updateFormat(newFormat);
  }
}
