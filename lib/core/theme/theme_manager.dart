import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_theme.dart';

class ThemeManager extends ChangeNotifier {
  static const String _themeKey = 'theme';
  AppThemeType _currentTheme = AppThemeType.normal;

  AppThemeType get currentTheme => _currentTheme;

  ThemeManager() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_themeKey) ?? AppThemeType.normal.name;
    _currentTheme = AppThemeType.values.firstWhere((e) => e.name == themeName);
    notifyListeners();
  }

  Future<void> setTheme(AppThemeType theme) async {
    _currentTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, theme.name);
    notifyListeners();
  }

  void nextTheme() {
    final nextThemeIndex =
        (_currentTheme.index + 1) % AppThemeType.values.length;
    setTheme(AppThemeType.values[nextThemeIndex]);
  }
}
