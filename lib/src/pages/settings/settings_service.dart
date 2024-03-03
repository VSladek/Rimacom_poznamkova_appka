import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../notes/note_saving.dart';

class SettingsService {
  static const String _themeKey = 'theme';
  static const String _languageKey = 'language';
  static const String _formatKey = 'format';

  Future<void> updateThemeMode(ThemeMode theme) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    await settings.setInt(_themeKey, theme.index);
  }

  Future<ThemeMode> getThemeMode() async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    final int? themeIndex = settings.getInt(_themeKey);
    return themeIndex != null ? ThemeMode.values[themeIndex] : ThemeMode.system;
  }

  Future<void> updateLocalization(Locale locale) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    await settings.setString(_languageKey, locale.languageCode);
    }

  Future<Locale> getLocalization() async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    final String? languageCode = settings.getString(_languageKey);
    return languageCode != null ? Locale(languageCode) : const Locale('cs');
  }

  Future<void> updateFormat(NoteSaveFormat format) async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    await settings.setString(_formatKey, format.format);
  }

  Future<NoteSaveFormat> getFormat() async {
    final SharedPreferences settings = await SharedPreferences.getInstance();
    final String? format = settings.getString(_formatKey);
    return format != null ? NoteSaveFormat(format) : const NoteSaveFormat('json');
  }

}