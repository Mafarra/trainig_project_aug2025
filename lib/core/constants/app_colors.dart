import 'package:flutter/material.dart';

/// Comprehensive color system for the Todo app
/// All colors used throughout the application should be defined here
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ===== PRIMARY COLORS =====
  static const Color primary = Color(0xFFFF9800); // Orange
  static const Color primaryLight = Color(0xFFFFB74D);
  static const Color primaryDark = Color(0xFFF57C00);

  // ===== SECONDARY COLORS =====
  static const Color secondary = Color(0xFFFFC107); // Amber
  static const Color secondaryLight = Color(0xFFFFD54F);
  static const Color secondaryDark = Color(0xFFFF8F00);

  // ===== ACCENT COLORS =====
  static const Color accent = Color(0xFF2196F3); // Blue
  static const Color accentLight = Color(0xFF64B5F6);
  static const Color accentDark = Color(0xFF1976D2);

  // ===== SUCCESS COLORS =====
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  // ===== ERROR COLORS =====
  static const Color error = Color(0xFFF44336); // Red
  static const Color errorLight = Color(0xFFE57373);
  static const Color errorDark = Color(0xFFD32F2F);

  // ===== WARNING COLORS =====
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  // ===== NEUTRAL COLORS =====
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

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
  static const Color lightSurface = white;
  static const Color lightCardBackground = white;
  static const Color lightTextPrimary = Color(0xFF212121);
  static const Color lightTextSecondary = Color(0xFF757575);
  static const Color lightTextDisabled = Color(0xFFBDBDBD);
  static const Color lightDivider = Color(0x4D000000);
  static const Color lightDividerLight = Color(0x1F000000);

  // ===== LEGACY COLORS (for backward compatibility) =====
  static const Color background = lightBackground;
  static const Color surface = lightSurface;
  static const Color cardBackground = lightCardBackground;
  static const Color textPrimary = lightTextPrimary;
  static const Color textSecondary = lightTextSecondary;
  static const Color textDisabled = lightTextDisabled;
  static const Color textOnPrimary = white;
  static const Color textOnSecondary = black;
  static const Color divider = lightDivider;
  static const Color dividerLight = lightDividerLight;

  // ===== SHADOW COLORS =====
  static const Color shadow = Color(0x1F000000); // Black with 12% opacity
  static const Color shadowLight = Color(0x0A000000); // Black with 4% opacity

  // ===== SPECIFIC UI COLORS =====

  // Task-related colors
  static const Color taskDefault = white;
  static const Color taskSelected = accent;
  static const Color taskPriority = accent;

  // Button colors
  static const Color buttonPrimary = primary;
  static const Color buttonSecondary = secondary;
  static const Color buttonSuccess = success;
  static const Color buttonError = error;

  // Dismissible background colors
  static const Color dismissibleSuccess = success;
  static const Color dismissibleError = error;
  static const Color dismissibleIcon = white;

  // Shimmer colors
  static const Color shimmerBase = gray300;
  static const Color shimmerHighlight = gray100;
  static const Color shimmerEnd = gray300;

  // Empty state colors
  static const Color emptyStateText = gray500;

  // ===== THEME-RELATED COLORS =====
  static const Color scaffoldBackground = background;
  static const Color appBarBackground = primary;
  static const Color appBarForeground = white;
  static const Color floatingActionButton = primary;
  static const Color floatingActionButtonIcon = white;

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
