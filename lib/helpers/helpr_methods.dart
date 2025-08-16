import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class HelperMethods {
  /// تحقق إذا كانت أي من الحقول فارغة
  static bool areFieldsEmpty(List<TextEditingController> controllers) {
    return controllers.any((c) => c.text.trim().isEmpty);
  }

  /// عرض رسالة خطأ للمستخدم
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  /// حفظ البيانات (يمكن تعديلها حسب مشروعك)
  static Future<void> saveTodo({
    required TodoBloc bloc,
    required Todo todo,
    required bool isNew,
    required BuildContext context,
  }) async {
    todo.name = todo.name;
    todo.description = todo.description;
    todo.completeBy = todo.completeBy;
    todo.priority = todo.priority;
    if (isNew) {
      bloc.todoInsertSink.add(todo);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(TextConstants.saveSuccess)));
    } else {
      bloc.todoUpdateSink.add(todo);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(TextConstants.updateSuccess)));
    }
  }


  static Future<bool> showDeleteConfirmationDialog(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(TextConstants.deleteConfirmationTitle),
          content: Text(TextConstants.deleteConfirmationMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(TextConstants.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(TextConstants.delete),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  /// Sort todos by priority in ascending order
  static List<Todo> sortTodosByPriority(List<Todo> todos) {
    // Ascending: lower priority number comes first
    todos.sort((a, b) => a.priority.compareTo(b.priority));
    return todos;
  }

  /// Check if a string is not empty
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Check if a string can be parsed to an integer
  static bool isInteger(String? value) {
    if (value == null) return false;
    return int.tryParse(value) != null;
  }

  /// Check if a string can be parsed to a double
  static bool isDouble(String? value) {
    if (value == null) return false;
    return double.tryParse(value) != null;
  }

  /// Check if a string is a valid email
  static bool isEmail(String? value) {
    if (value == null) return false;
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(value);
  }

  /// Check if a string contains only letters
  static bool isAlphabetic(String? value) {
    if (value == null) return false;
    final regex = RegExp(r'^[a-zA-Z]+$');
    return regex.hasMatch(value);
  }

  /// Check if a string contains only letters and numbers
  static bool isAlphanumeric(String? value) {
    if (value == null) return false;
    final regex = RegExp(r'^[a-zA-Z0-9]+$');
    return regex.hasMatch(value);
  }

  /// Check if a boolean is true
  static bool isTrue(bool? value) {
    return value == true;
  }

  /// Check if a boolean is false
  static bool isFalse(bool? value) {
    return value == false;
  }

  /// Generic range check for numbers
  static bool isInRange(num value, {required num min, required num max}) {
    return value >= min && value <= max;
  }
}
