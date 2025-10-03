import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

/// Clave para guardar la preferencia del modo de tema en SharedPreferences
const String _themePreferenceKey = 'theme_mode';

/// Provider para gestionar el modo de tema (claro/oscuro)
@riverpod
class ThemeNotifier extends _$ThemeNotifier {
  @override
  ThemeMode build() {
    _loadThemePreference();
    return ThemeMode.system; // Por defecto usa el tema del sistema
  }

  /// Carga la preferencia de tema guardada
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString(_themePreferenceKey);

    if (savedTheme != null) {
      state = _themeModeFromString(savedTheme);
    }
  }

  /// Cambia el modo de tema
  Future<void> setThemeMode(ThemeMode mode) async {
    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themePreferenceKey, mode.toString());
  }

  /// Alterna entre modo claro y oscuro
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Verifica si el tema actual es oscuro
  bool get isDarkMode => state == ThemeMode.dark;

  /// Verifica si está usando el tema del sistema
  bool get isSystemMode => state == ThemeMode.system;

  /// Convierte un string a ThemeMode
  ThemeMode _themeModeFromString(String value) {
    switch (value) {
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        return ThemeMode.system;
    }
  }
}
