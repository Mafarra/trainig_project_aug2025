import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sembast/sembast_io.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class TodoDb {
  // Singleton instance
  static final TodoDb _singleton = TodoDb._internal();

  // Private internal constructor
  TodoDb._internal();

  factory TodoDb() => _singleton;

  final DatabaseFactory dbFactory = databaseFactoryIo;
  final StoreRef<int, Map<String, dynamic>> store = intMapStoreFactory.store(
    'todos',
  );

  Database? _database; // Nullable لحماية null safety

  // Getter آمن للقاعدة
  Future<Database> get database async {
    _database ??= await _openDb();
    return _database!;
  }

  Future<Database> _openDb() async {
    final docsPath = await getApplicationDocumentsDirectory();
    final dbPath = join(docsPath.path, 'todos.db');
    final db = await dbFactory.openDatabase(dbPath);
    return db;
  }

  Future<void> insertTodo(Todo todo) async {
    final db = await database;
    await store.add(db, todo.toMap());
  }

  Future<void> updateTodo(Todo todo) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.update(db, todo.toMap(), finder: finder);
  }

  Future<void> deleteTodo(Todo todo) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(todo.id));
    await store.delete(db, finder: finder);
  }

  Future<void> deleteAll() async {
    final db = await database;
    await store.delete(db);
  }

  Future<List<Todo>> getTodos() async {
    final db = await database;
    final finder = Finder(sortOrders: [SortOrder('priority'), SortOrder('id')]);
    final todosSnapshot = await store.find(db, finder: finder);

    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key; // id يتم توليده تلقائيًا
      return todo;
    }).toList();
  }

  // Get todos with date filtering
  Future<List<Todo>> getTodosByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    final db = await database;
    final finder = Finder(
      filter: Filter.and([
        Filter.greaterThan('endDate', startDate.millisecondsSinceEpoch - 1),
        Filter.lessThan('endDate', endDate.millisecondsSinceEpoch + 1),
      ]),
      sortOrders: [SortOrder('endDate'), SortOrder('priority')],
    );
    final todosSnapshot = await store.find(db, finder: finder);

    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }

  // Get overdue todos
  Future<List<Todo>> getOverdueTodos() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final finder = Finder(
      filter: Filter.and([
        Filter.lessThan('endDate', now),
        Filter.equals('isCompleted', 0),
      ]),
      sortOrders: [SortOrder('endDate'), SortOrder('priority')],
    );
    final todosSnapshot = await store.find(db, finder: finder);

    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }

  // Get todos due today
  Future<List<Todo>> getTodosDueToday() async {
    final now = DateTime.now();
    final startOfDay = DateTime(
      now.year,
      now.month,
      now.day,
    ).millisecondsSinceEpoch;
    final endOfDay = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
    ).millisecondsSinceEpoch;

    return getTodosByDateRange(
      DateTime.fromMillisecondsSinceEpoch(startOfDay),
      DateTime.fromMillisecondsSinceEpoch(endOfDay),
    );
  }

  // Get todos with reminders
  Future<List<Todo>> getTodosWithReminders() async {
    final db = await database;
    final finder = Finder(
      filter: Filter.notEquals('reminderDate', null),
      sortOrders: [SortOrder('reminderDate'), SortOrder('priority')],
    );
    final todosSnapshot = await store.find(db, finder: finder);

    return todosSnapshot.map((snapshot) {
      final todo = Todo.fromMap(snapshot.value);
      todo.id = snapshot.key;
      return todo;
    }).toList();
  }

  // Update todo completion status
  Future<void> updateTodoCompletion(int todoId, bool isCompleted) async {
    final db = await database;
    final finder = Finder(filter: Filter.byKey(todoId));
    final updateData = {
      'isCompleted': isCompleted ? 1 : 0,
      'completedAt': isCompleted ? DateTime.now().millisecondsSinceEpoch : null,
    };
    await store.update(db, updateData, finder: finder);
  }
}
