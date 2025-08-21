import 'package:flutter/material.dart';

/// Theme constants for the Todo app
/// Handles both light and dark theme colors
class ThemeConstants {
  // Private constructor to prevent instantiation
  ThemeConstants._();

  // ===== DARK THEME COLORS =====
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCardBackground = Color(0xFF2D2D2D);
  static const Color darkTextPrimary = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  static const Color darkTextDisabled = Color(0xFF666666);
  static const Color darkDivider = Color(0x4DFFFFFF);
  static const Color darkDividerLight = Color(0x1FFFFFFF);

  // ===== LIGHT THEME COLORS =====
  static const Color lightBackground = Color(
    0xFFFFF8E1,
  ); // Light amber background
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCardBackground = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextDisabled = Color(0xFFBDBDBD);
  static const Color lightDivider = Color(0x4D000000);
  static const Color lightDividerLight = Color(0x1F000000);

  // ===== GRAY SCALE =====
  static const Color gray50 = Color(0xFFFAFAFA);
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);

  // ===== THEME-AWARE COLOR GETTERS =====

  /// Get background color based on theme
  static Color getBackgroundColor(bool isDark) {
    return isDark ? darkBackground : lightBackground;
  }

  /// Get surface color based on theme
  static Color getSurfaceColor(bool isDark) {
    return isDark ? darkSurface : lightSurface;
  }

  /// Get card background color based on theme
  static Color getCardBackgroundColor(bool isDark) {
    return isDark ? darkCardBackground : lightCardBackground;
  }

  /// Get primary text color based on theme
  static Color getTextPrimaryColor(bool isDark) {
    return isDark ? darkTextPrimary : lightTextPrimary;
  }

  /// Get secondary text color based on theme
  static Color getTextSecondaryColor(bool isDark) {
    return isDark ? darkTextSecondary : lightTextSecondary;
  }

  /// Get disabled text color based on theme
  static Color getTextDisabledColor(bool isDark) {
    return isDark ? darkTextDisabled : lightTextDisabled;
  }

  /// Get divider color based on theme
  static Color getDividerColor(bool isDark) {
    return isDark ? darkDivider : lightDivider;
  }

  /// Get light divider color based on theme
  static Color getDividerLightColor(bool isDark) {
    return isDark ? darkDividerLight : lightDividerLight;
  }

  /// Get shimmer base color based on theme
  static Color getShimmerBaseColor(bool isDark) {
    return isDark ? gray700 : gray300;
  }

  /// Get shimmer highlight color based on theme
  static Color getShimmerHighlightColor(bool isDark) {
    return isDark ? gray600 : gray100;
  }

  /// Get empty state text color based on theme
  static Color getEmptyStateTextColor(bool isDark) {
    return isDark ? gray400 : gray500;
  }
}
