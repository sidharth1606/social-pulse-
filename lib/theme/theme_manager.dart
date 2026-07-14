import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global theme state for SocialPulse.
///
/// This is intentionally a plain ChangeNotifier (no external state
/// management package needed) so the whole feature stays free and
/// dependency-light. Any widget that needs to react to theme changes
/// wraps itself in an AnimatedBuilder listening to `themeManager`.
class ThemeManager extends ChangeNotifier {
  ThemeManager._internal();
  static final ThemeManager instance = ThemeManager._internal();

  static const _prefsKey = 'sp_is_dark_mode';

  bool _isDark = true; // app has always defaulted to dark
  bool get isDark => _isDark;

  bool _loaded = false;
  bool get isLoaded => _loaded;

  /// Call once, early in main(), before runApp.
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _isDark = prefs.getBool(_prefsKey) ?? true;
    _loaded = true;
    notifyListeners();
  }

  Future<void> setDark(bool value) async {
    if (_isDark == value) return;
    _isDark = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_prefsKey, value);
  }

  Future<void> toggle() => setDark(!_isDark);
}

/// Shorthand accessor used throughout the app.
final themeManager = ThemeManager.instance;
