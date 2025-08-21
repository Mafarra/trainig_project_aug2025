import 'package:trainig_project_aug2025/core/repositories/preferences_repository.dart';

/// Example service that uses the centralized PreferencesRepository
/// Demonstrates how to follow Clean Architecture principles
class UserPreferencesService {
  static final UserPreferencesService _instance =
      UserPreferencesService._internal();
  factory UserPreferencesService() => _instance;
  UserPreferencesService._internal();

  final PreferencesRepository _preferencesRepository = PreferencesRepository();

  // ===== NOTIFICATION PREFERENCES =====

  /// Save notification preferences
  Future<bool> saveNotificationPreferences({
    required bool enabled,
    required bool soundEnabled,
    required bool vibrationEnabled,
  }) async {
    try {
      final preferences = {
        'notifications_enabled': enabled,
        'sound_enabled': soundEnabled,
        'vibration_enabled': vibrationEnabled,
      };

      return await _preferencesRepository.saveUserPreferences(preferences);
    } catch (e) {
      print('Failed to save notification preferences: $e');
      return false;
    }
  }

  /// Get notification preferences
  Future<Map<String, bool>> getNotificationPreferences() async {
    try {
      final preferences = await _preferencesRepository.getUserPreferences();
      if (preferences != null) {
        return {
          'notifications_enabled': preferences['notifications_enabled'] ?? true,
          'sound_enabled': preferences['sound_enabled'] ?? true,
          'vibration_enabled': preferences['vibration_enabled'] ?? true,
        };
      }
      return {
        'notifications_enabled': true,
        'sound_enabled': true,
        'vibration_enabled': true,
      };
    } catch (e) {
      print('Failed to get notification preferences: $e');
      return {
        'notifications_enabled': true,
        'sound_enabled': true,
        'vibration_enabled': true,
      };
    }
  }

  // ===== TODO PREFERENCES =====

  /// Save todo preferences
  Future<bool> saveTodoPreferences({
    required int defaultPriority,
    required int defaultReminderTime,
    required bool showCompletedTasks,
    required String sortBy,
  }) async {
    try {
      final preferences = {
        'default_priority': defaultPriority,
        'default_reminder_time': defaultReminderTime,
        'show_completed_tasks': showCompletedTasks,
        'sort_by': sortBy,
      };

      return await _preferencesRepository.saveUserPreferences(preferences);
    } catch (e) {
      print('Failed to save todo preferences: $e');
      return false;
    }
  }

  /// Get todo preferences
  Future<Map<String, dynamic>> getTodoPreferences() async {
    try {
      final preferences = await _preferencesRepository.getUserPreferences();
      if (preferences != null) {
        return {
          'default_priority': preferences['default_priority'] ?? 1,
          'default_reminder_time': preferences['default_reminder_time'] ?? 15,
          'show_completed_tasks': preferences['show_completed_tasks'] ?? true,
          'sort_by': preferences['sort_by'] ?? 'priority',
        };
      }
      return {
        'default_priority': 1,
        'default_reminder_time': 15,
        'show_completed_tasks': true,
        'sort_by': 'priority',
      };
    } catch (e) {
      print('Failed to get todo preferences: $e');
      return {
        'default_priority': 1,
        'default_reminder_time': 15,
        'show_completed_tasks': true,
        'sort_by': 'priority',
      };
    }
  }

  // ===== UI PREFERENCES =====

  /// Save UI preferences
  Future<bool> saveUIPreferences({
    required String animationSpeed,
    required bool compactMode,
    required bool showPriorityColors,
    required bool showDueDates,
  }) async {
    try {
      final preferences = {
        'animation_speed': animationSpeed,
        'compact_mode': compactMode,
        'show_priority_colors': showPriorityColors,
        'show_due_dates': showDueDates,
      };

      return await _preferencesRepository.saveUserPreferences(preferences);
    } catch (e) {
      print('Failed to save UI preferences: $e');
      return false;
    }
  }

  /// Get UI preferences
  Future<Map<String, dynamic>> getUIPreferences() async {
    try {
      final preferences = await _preferencesRepository.getUserPreferences();
      if (preferences != null) {
        return {
          'animation_speed': preferences['animation_speed'] ?? 'normal',
          'compact_mode': preferences['compact_mode'] ?? false,
          'show_priority_colors': preferences['show_priority_colors'] ?? true,
          'show_due_dates': preferences['show_due_dates'] ?? true,
        };
      }
      return {
        'animation_speed': 'normal',
        'compact_mode': false,
        'show_priority_colors': true,
        'show_due_dates': true,
      };
    } catch (e) {
      print('Failed to get UI preferences: $e');
      return {
        'animation_speed': 'normal',
        'compact_mode': false,
        'show_priority_colors': true,
        'show_due_dates': true,
      };
    }
  }

  // ===== UTILITY METHODS =====

  /// Clear all user preferences
  Future<bool> clearAllPreferences() async {
    try {
      return await _preferencesRepository.clearAllPreferences();
    } catch (e) {
      print('Failed to clear preferences: $e');
      return false;
    }
  }

  /// Check if first launch
  Future<bool> isFirstLaunch() async {
    try {
      final settings = await _preferencesRepository.getAppSettings();
      return settings?['first_launch'] ?? true;
    } catch (e) {
      print('Failed to check first launch: $e');
      return true;
    }
  }

  /// Mark first launch as completed
  Future<bool> markFirstLaunchComplete() async {
    try {
      final settings = {'first_launch': false};
      return await _preferencesRepository.saveAppSettings(settings);
    } catch (e) {
      print('Failed to mark first launch complete: $e');
      return false;
    }
  }
}
