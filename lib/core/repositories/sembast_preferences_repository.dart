import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:trainig_project_aug2025/core/constants/preferences_constants.dart';

/// Sembast-based preferences repository
class SembastPreferencesRepository {
  static final SembastPreferencesRepository _instance =
      SembastPreferencesRepository._internal();
  factory SembastPreferencesRepository() => _instance;
  SembastPreferencesRepository._internal();

  final DatabaseFactory _dbFactory = databaseFactoryIo;
  final StoreRef<String, Map<String, dynamic>> _preferencesStore =
      stringMapStoreFactory.store('preferences');

  Database? _database;

  Future<Database> get database async {
    _database ??= await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'preferences.db');
    return await _dbFactory.openDatabase(dbPath);
  }

  // Theme preferences
  Future<bool> saveThemeMode(int themeModeIndex) async {
    try {
      final db = await database;
      await _preferencesStore.record(PreferencesConstants.themeMode).put(db, {
        'value': themeModeIndex,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
      return true;
    } catch (e) {
      print('Failed to save theme mode: $e');
      return false;
    }
  }

  Future<int?> getThemeMode() async {
    try {
      final db = await database;
      final record = await _preferencesStore
          .record(PreferencesConstants.themeMode)
          .get(db);
      return record?['value'] as int?;
    } catch (e) {
      print('Failed to get theme mode: $e');
      return null;
    }
  }

  // User preferences
  Future<bool> saveUserPreferences(Map<String, dynamic> preferences) async {
    try {
      final db = await database;
      await _preferencesStore.record(PreferencesConstants.userPreferences).put(
        db,
        {...preferences, 'lastUpdated': DateTime.now().millisecondsSinceEpoch},
      );
      return true;
    } catch (e) {
      print('Failed to save user preferences: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>?> getUserPreferences() async {
    try {
      final db = await database;
      final record = await _preferencesStore
          .record(PreferencesConstants.userPreferences)
          .get(db);
      return record;
    } catch (e) {
      print('Failed to get user preferences: $e');
      return null;
    }
  }

  // Utility methods
  Future<bool> clearAllPreferences() async {
    try {
      final db = await database;
      await _preferencesStore.delete(db);
      return true;
    } catch (e) {
      print('Failed to clear preferences: $e');
      return false;
    }
  }

  Future<void> close() async {
    await _database?.close();
    _database = null;
  }
}
