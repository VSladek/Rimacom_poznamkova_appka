import 'package:flutter/material.dart';
import '';

class NoteSaveFormat {
  static const String txt = 'txt';
  static const String json = 'json';

  final String format;

  const NoteSaveFormat(this.format);

  bool isSupported() {
    return format == txt || format == json;
  }

  static NoteSaveFormat? fromString(String formatString) {
    if (formatString == txt || formatString == json) {
      return NoteSaveFormat(formatString);
    }
    return null;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoteSaveFormat && other.format == format;
  }

  @override
  int get hashCode => format.hashCode;
}