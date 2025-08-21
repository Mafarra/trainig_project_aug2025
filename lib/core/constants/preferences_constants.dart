/// Constants for SharedPreferences keys
/// Centralizes all preference keys to avoid magic strings
class PreferencesConstants {
  // Private constructor to prevent instantiation
  PreferencesConstants._();

  // ===== THEME PREFERENCES =====
  static const String themeMode = 'theme_mode';

  // ===== SYNC PREFERENCES =====
  static const String lastSync = 'last_sync';
  static const String syncEnabled = 'sync_enabled';
  static const String syncInterval = 'sync_interval';

  // ===== USER PREFERENCES =====
  static const String userPreferences = 'user_preferences';
  static const String userName = 'user_name';
  static const String userEmail = 'user_email';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String soundEnabled = 'sound_enabled';
  static const String vibrationEnabled = 'vibration_enabled';

  // ===== APP SETTINGS =====
  static const String appSettings = 'app_settings';
  static const String language = 'language';
  static const String fontSize = 'font_size';
  static const String autoBackup = 'auto_backup';
  static const String firstLaunch = 'first_launch';

  // =====  SPECIFIC PREFERENCES =====
  static const String todoPreferences = 'todo_preferences';
  static const String defaultPriority = 'default_priority';
  static const String defaultReminderTime = 'default_reminder_time';
  static const String showCompletedTasks = 'show_completed_tasks';
  static const String sortBy = 'sort_by';
  static const String filterBy = 'filter_by';

  // ===== UI PREFERENCES =====
  static const String uiPreferences = 'ui_preferences';
  static const String animationSpeed = 'animation_speed';
  static const String compactMode = 'compact_mode';
  static const String showPriorityColors = 'show_priority_colors';
  static const String showDueDates = 'show_due_dates';
}
