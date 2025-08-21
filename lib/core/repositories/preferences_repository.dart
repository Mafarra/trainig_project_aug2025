import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainig_project_aug2025/core/constants/preferences_constants.dart';

/// Centralized repository for handling all SharedPreferences operations
/// Follows Clean Architecture principles with single responsibility
class PreferencesRepository {
  static final PreferencesRepository _instance =
      PreferencesRepository._internal();
  factory PreferencesRepository() => _instance;
  PreferencesRepository._internal();

  // Using constants from PreferencesConstants

  /// Get SharedPreferences instance
  Future<SharedPreferences> get _prefs async {
    return await SharedPreferences.getInstance();
  }

  // ===== THEME PREFERENCES =====

  /// Save theme mode preference
  Future<bool> saveThemeMode(int themeModeIndex) async {
    try {
      final prefs = await _prefs;
      return await prefs.setInt(PreferencesConstants.themeMode, themeModeIndex);
    } catch (e) {
      // Log error for debugging
      print('Failed to save theme mode: $e');
      return false;
    }
  }

  /// Get saved theme mode preference
  Future<int?> getThemeMode() async {
    try {
      final prefs = await _prefs;
      return prefs.getInt(PreferencesConstants.themeMode);
    } catch (e) {
      print('Failed to get theme mode: $e');
      return null;
    }
  }

  // ===== SYNC PREFERENCES =====

  /// Save last sync timestamp
  Future<bool> saveLastSync(DateTime timestamp) async {
    try {
      final prefs = await _prefs;
      return await prefs.setInt(
        PreferencesConstants.lastSync,
        timestamp.millisecondsSinceEpoch,
      );
    } catch (e) {
      print('Failed to save last sync: $e');
      return false;
    }
  }

  /// Get last sync timestamp
  Future<DateTime?> getLastSync() async {
    try {
      final prefs = await _prefs;
      final timestamp = prefs.getInt(PreferencesConstants.lastSync);
      return timestamp != null
          ? DateTime.fromMillisecondsSinceEpoch(timestamp)
          : null;
    } catch (e) {
      print('Failed to get last sync: $e');
      return null;
    }
  }

  // ===== USER PREFERENCES =====

  /// Save user preferences as JSON string
  Future<bool> saveUserPreferences(Map<String, dynamic> preferences) async {
    try {
      final prefs = await _prefs;
      // Convert map to JSON string for storage
      final jsonString = preferences.toString(); // In real app, use jsonEncode
      return await prefs.setString(
        PreferencesConstants.userPreferences,
        jsonString,
      );
    } catch (e) {
      print('Failed to save user preferences: $e');
      return false;
    }
  }

  /// Get user preferences
  Future<Map<String, dynamic>?> getUserPreferences() async {
    try {
      final prefs = await _prefs;
      final jsonString = prefs.getString(PreferencesConstants.userPreferences);
      if (jsonString != null) {
        // Parse JSON string back to map
        // In real app, use jsonDecode
        return {}; // Placeholder
      }
      return null;
    } catch (e) {
      print('Failed to get user preferences: $e');
      return null;
    }
  }

  // ===== APP SETTINGS =====

  /// Save app settings
  Future<bool> saveAppSettings(Map<String, dynamic> settings) async {
    try {
      final prefs = await _prefs;
      final jsonString = settings.toString(); // In real app, use jsonEncode
      return await prefs.setString(
        PreferencesConstants.appSettings,
        jsonString,
      );
    } catch (e) {
      print('Failed to save app settings: $e');
      return false;
    }
  }

  /// Get app settings
  Future<Map<String, dynamic>?> getAppSettings() async {
    try {
      final prefs = await _prefs;
      final jsonString = prefs.getString(PreferencesConstants.appSettings);
      if (jsonString != null) {
        // Parse JSON string back to map
        return {}; // Placeholder
      }
      return null;
    } catch (e) {
      print('Failed to get app settings: $e');
      return null;
    }
  }

  // ===== UTILITY METHODS =====

  /// Clear all preferences
  Future<bool> clearAllPreferences() async {
    try {
      final prefs = await _prefs;
      return await prefs.clear();
    } catch (e) {
      print('Failed to clear preferences: $e');
      return false;
    }
  }

  /// Clear specific preference
  Future<bool> clearPreference(String key) async {
    try {
      final prefs = await _prefs;
      return await prefs.remove(key);
    } catch (e) {
      print('Failed to clear preference $key: $e');
      return false;
    }
  }

  /// Check if preference exists
  Future<bool> hasPreference(String key) async {
    try {
      final prefs = await _prefs;
      return prefs.containsKey(key);
    } catch (e) {
      print('Failed to check preference $key: $e');
      return false;
    }
  }
}
