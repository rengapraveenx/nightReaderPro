import 'package:flutter/material.dart';

enum AppThemeType { warm, cool, normal }

class AppTheme {
  static final Map<AppThemeType, ThemeData> _themes = {
    AppThemeType.normal: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.black,
    ),
    AppThemeType.warm: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.deepOrange,
    ),
    AppThemeType.cool: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Colors.blue,
    ),
  };

  static final Map<AppThemeType, Gradient> gradients = {
    AppThemeType.normal: const LinearGradient(
      colors: [Colors.white, Colors.white],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    AppThemeType.warm: const LinearGradient(
      colors: [Colors.deepOrange, Colors.orangeAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    AppThemeType.cool: const LinearGradient(
      colors: [Colors.blue, Colors.lightBlueAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  };

  static ThemeData getTheme(AppThemeType type) {
    return _themes[type]!;
  }

  static Gradient getGradient(AppThemeType type) {
    return gradients[type]!;
  }
}
