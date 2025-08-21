import 'dart:async';
import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/services/theme_service.dart';

class ThemeBloc {
  final ThemeService _themeService = ThemeService();

  // Stream controllers
  final _themeModeController = StreamController<AppThemeMode>.broadcast();
  final _isDarkModeController = StreamController<bool>.broadcast();

  // Getters for streams
  Stream<AppThemeMode> get themeMode => _themeModeController.stream;
  Stream<bool> get isDarkMode => _isDarkModeController.stream;

  // Current state
  AppThemeMode _currentThemeMode = AppThemeMode.system;
  bool _isDarkMode = false;

  // Getters for current state
  AppThemeMode get currentThemeMode => _currentThemeMode;
  bool get isDarkModeValue => _isDarkMode;

  ThemeBloc() {
    _initialize();
  }

  /// Initialize the theme bloc
  Future<void> _initialize() async {
    await _themeService.initialize();

    // Listen to theme service changes
    _themeService.themeModeNotifier.addListener(_onThemeModeChanged);

    // Set initial values
    _currentThemeMode = _themeService.currentThemeMode;
    _themeModeController.add(_currentThemeMode);
  }

  /// Handle theme mode changes
  void _onThemeModeChanged() {
    _currentThemeMode = _themeService.currentThemeMode;
    _themeModeController.add(_currentThemeMode);
  }

  /// Set theme mode
  Future<void> setThemeMode(AppThemeMode themeMode) async {
    await _themeService.setThemeMode(themeMode);
  }

  /// Check if dark mode is active for a given context
  bool isDarkModeForContext(BuildContext context) {
    return _themeService.isDarkMode(context);
  }

  /// Update dark mode status for a context
  void updateDarkModeStatus(BuildContext context) {
    _isDarkMode = _themeService.isDarkMode(context);
    _isDarkModeController.add(_isDarkMode);
  }

  /// Toggle between light and dark mode
  Future<void> toggleTheme() async {
    final newMode = _currentThemeMode == AppThemeMode.light
        ? AppThemeMode.dark
        : AppThemeMode.light;
    await setThemeMode(newMode);
  }

  /// Set light mode
  Future<void> setLightMode() async {
    await setThemeMode(AppThemeMode.light);
  }

  /// Set dark mode
  Future<void> setDarkMode() async {
    await setThemeMode(AppThemeMode.dark);
  }

  /// Set system mode
  Future<void> setSystemMode() async {
    await setThemeMode(AppThemeMode.system);
  }

  /// Dispose resources
  void dispose() {
    _themeService.themeModeNotifier.removeListener(_onThemeModeChanged);
    _themeModeController.close();
    _isDarkModeController.close();
  }
}
