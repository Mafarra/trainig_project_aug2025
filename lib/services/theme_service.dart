import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/core/repositories/preferences_repository.dart';

enum AppThemeMode { light, dark, system }

class ThemeService {
  static final ThemeService _instance = ThemeService._internal();
  factory ThemeService() => _instance;
  ThemeService._internal();

  final PreferencesRepository _preferencesRepository = PreferencesRepository();

  final ValueNotifier<AppThemeMode> _themeModeNotifier =
      ValueNotifier<AppThemeMode>(AppThemeMode.system);

  ValueNotifier<AppThemeMode> get themeModeNotifier => _themeModeNotifier;

  /// Initialize theme service and load saved theme
  Future<void> initialize() async {
    await _loadThemeMode();
  }

  /// Load saved theme mode from PreferencesRepository
  Future<void> _loadThemeMode() async {
    try {
      final themeIndex =
          await _preferencesRepository.getThemeMode() ??
          AppThemeMode.system.index;
      _themeModeNotifier.value = AppThemeMode.values[themeIndex];
    } catch (e) {
      // Fallback to system theme if loading fails
      _themeModeNotifier.value = AppThemeMode.system;
    }
  }

  /// Save theme mode to PreferencesRepository
  Future<void> _saveThemeMode(AppThemeMode themeMode) async {
    try {
      await _preferencesRepository.saveThemeMode(themeMode.index);
    } catch (e) {
      // Handle save error
      debugPrint('Failed to save theme mode: $e');
    }
  }

  /// Set theme mode and save to preferences
  Future<void> setThemeMode(AppThemeMode themeMode) async {
    _themeModeNotifier.value = themeMode;
    await _saveThemeMode(themeMode);
  }

  /// Get current theme mode
  AppThemeMode get currentThemeMode => _themeModeNotifier.value;

  /// Check if dark mode is active
  bool isDarkMode(BuildContext context) {
    switch (_themeModeNotifier.value) {
      case AppThemeMode.light:
        return false;
      case AppThemeMode.dark:
        return true;
      case AppThemeMode.system:
        return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
  }

  /// Dispose resources
  void dispose() {
    _themeModeNotifier.dispose();
  }
}
