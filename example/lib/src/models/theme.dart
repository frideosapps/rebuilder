import 'package:flutter/material.dart';

class AppThemes {
  Map<String, ThemeData> themes;
}

final themes = {
  'Default': ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.blue[50],
    scaffoldBackgroundColor: Colors.blue[50],
    primaryColor: Colors.blue,
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.blue[300],
  ),
  'Teal': ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.teal[50],
    scaffoldBackgroundColor: Colors.teal[50],
    primaryColor: Colors.teal[600],
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.teal[300],
  ),
  'Orange': ThemeData(
    brightness: Brightness.light,
    backgroundColor: Colors.orange[50],
    scaffoldBackgroundColor: Colors.orange[50],
    primaryColor: Colors.orange[600],
    primaryColorBrightness: Brightness.dark,
    accentColor: Colors.orange[300],
  ),
  'Dark': ThemeData.dark(),
};
