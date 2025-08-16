import 'dart:async';
import 'package:trainig_project_aug2025/features/todo/data/todo_database.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class TodoBloc {
  final TodoDb db = TodoDb();
  List<Todo> todoList = [];

  // StreamControllers
  final _todosStreamController = StreamController<List<Todo>>.broadcast();
  final _todoInsertController = StreamController<Todo>();
  final _todoUpdateController = StreamController<Todo>();
  final _todoDeleteController = StreamController<Todo>();

  // Getters for streams and sinks
  Stream<List<Todo>> get todos => _todosStreamController.stream;
  StreamSink<List<Todo>> get todosSink => _todosStreamController.sink;
  StreamSink<Todo> get todoInsertSink => _todoInsertController.sink;
  StreamSink<Todo> get todoUpdateSink => _todoUpdateController.sink;
  StreamSink<Todo> get todoDeleteSink => _todoDeleteController.sink;

  // Constructor
  TodoBloc() {
    _todoInsertController.stream.listen(_addTodo);
    _todoUpdateController.stream.listen(_updateTodo);
    _todoDeleteController.stream.listen(_deleteTodo);

    // Load todos initially
    getTodos();
  }

  // Load todos from database
  Future<void> getTodos() async {
    final todosFromDb = await db.getTodos();
    await getTodosSorted(); // Sort todos by priority
    todoList = todosFromDb;
    _todosStreamController.add(todoList);
  }

  Future<void> getTodosSorted() async {
    final todos = await db.getTodos(); // get all todos
    final sortedTodos = HelperMethods.sortTodosByPriority(
      todos,
    ); // sort by priority ascending
    _todosStreamController.add(sortedTodos); // send to stream
  }

  // Add a new todo
  Future<void> _addTodo(Todo todo) async {
    await db.insertTodo(todo);
    await getTodos();
  }

  // Update a todo
  Future<void> _updateTodo(Todo todo) async {
    await db.updateTodo(todo);
    await getTodos();
  }

  // Delete a todo
  Future<void> _deleteTodo(Todo todo) async {
    await db.deleteTodo(todo);
    await getTodos();
  }

  // Dispose method to close streams
  void dispose() {
    _todosStreamController.close();
    _todoInsertController.close();
    _todoUpdateController.close();
    _todoDeleteController.close();
  }
}
