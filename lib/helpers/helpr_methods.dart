import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/models/todo.dart';
import 'package:trainig_project_aug2025/services/notification_service.dart';
import 'package:another_flushbar/flushbar.dart';

class HelperMethods {
  /// تحقق إذا كانت أي من الحقول فارغة
  static bool areFieldsEmpty(List<TextEditingController> controllers) {
    return controllers.any((c) => c.text.trim().isEmpty);
  }

  /// عرض رسالة خطأ للمستخدم باستخدام Flushbar
  static void showError(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.red.withValues(alpha: 0.95),
      icon: Icons.error_outline,
    );
  }

  /// عرض رسالة خطأ مع أيقونة مخصصة
  static void showErrorWithIcon(
    BuildContext context,
    String message,
    IconData icon,
  ) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.red.withValues(alpha: 0.95),
      icon: icon,
    );
  }

  /// عرض رسالة نجاح باستخدام Flushbar
  static void showSuccess(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.green.withValues(alpha: 0.95),
      icon: Icons.check_circle,
    );
  }

  /// عرض رسالة نجاح مع أيقونة مخصصة
  static void showSuccessWithIcon(
    BuildContext context,
    String message,
    IconData icon,
  ) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.green.withValues(alpha: 0.95),
      icon: icon,
    );
  }

  /// عرض رسالة تحذير باستخدام Flushbar
  static void showWarning(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.orange.withValues(alpha: 0.95),
      icon: Icons.warning,
    );
  }

  /// عرض رسالة تحذير مع أيقونة مخصصة
  static void showWarningWithIcon(
    BuildContext context,
    String message,
    IconData icon,
  ) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.orange.withValues(alpha: 0.95),
      icon: icon,
    );
  }

  /// عرض رسالة معلومات باستخدام Flushbar
  static void showInfo(BuildContext context, String message) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.blue.withValues(alpha: 0.95),
      icon: Icons.info,
    );
  }

  /// عرض رسالة معلومات مع أيقونة مخصصة
  static void showInfoWithIcon(
    BuildContext context,
    String message,
    IconData icon,
  ) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: Colors.blue.withValues(alpha: 0.95),
      icon: icon,
    );
  }

  /// عرض رسالة مع أزرار إجراءات باستخدام Flushbar
  static void showActionFlushbar({
    required BuildContext context,
    required String message,
    required String actionText,
    required VoidCallback onAction,
    Color backgroundColor = Colors.blue,
    IconData icon = Icons.info,
  }) {
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(16),
      backgroundColor: backgroundColor.withValues(alpha: 0.95),
      icon: Icon(icon, color: Colors.white, size: 28),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      mainButton: TextButton(
        onPressed: () {
          onAction();
        },
        child: Text(
          actionText,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      duration: Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.BOTTOM,
      animationDuration: Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      boxShadows: [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ).show(context);
  }

  /// إغلاق جميع رسائل Flushbar
  static void dismissAllFlushbars(BuildContext context) {
    // Note: Flushbar.dismiss() is not available in static context
    // This method is kept for future implementation
  }

  /// عرض رسالة Flushbar مع تخصيص كامل
  static void showCustomFlushbarWithDuration({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
    FlushbarPosition position = FlushbarPosition.BOTTOM,
  }) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
    );
  }

  /// عرض رسالة Flushbar مع تخصيص كامل للون والأيقونة
  static void showCustomFlushbarWithColor({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      icon: icon ?? Icons.info,
      duration: duration,
    );
  }

  /// عرض رسالة Flushbar مع تخصيص كامل للون والأيقونة
  static void showCustomFlushbarWithColorAndIcon({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    _showFlushbar(
      context: context,
      message: message,
      backgroundColor: backgroundColor,
      icon: icon,
      duration: duration,
    );
  }

  /// دالة مساعدة عامة لعرض Flushbar
  static void _showFlushbar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(16),
      backgroundColor: backgroundColor,
      icon: Icon(icon, color: Colors.white, size: 28),
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      duration: duration,
      flushbarPosition: FlushbarPosition.BOTTOM,
      animationDuration: Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      boxShadows: [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ).show(context);
  }

  /// عرض Flushbar مخصص بالكامل
  static void showCustomFlushbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    IconData? icon,
    Duration? duration,
    FlushbarPosition? position,
    Widget? mainButton,
  }) {
    Flushbar(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      borderRadius: BorderRadius.circular(16),
      backgroundColor: backgroundColor ?? Colors.blue.withValues(alpha: 0.95),
      icon: icon != null ? Icon(icon, color: Colors.white, size: 28) : null,
      messageText: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      duration: duration ?? Duration(seconds: 3),
      flushbarPosition: position ?? FlushbarPosition.BOTTOM,
      animationDuration: Duration(milliseconds: 300),
      forwardAnimationCurve: Curves.easeOut,
      reverseAnimationCurve: Curves.easeIn,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      mainButton: mainButton,
      boxShadows: [
        BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
      ],
    ).show(context);
  }

  /// حفظ البيانات (يمكن تعديلها حسب مشروعك)
  static Future<String> saveTodo({
    required TodoBloc bloc,
    required Todo todo,
    required bool isNew,
    required BuildContext context,
  }) async {
    // ✅ تحقق من الحقول
    if (isNew) {
      bloc.todoInsertSink.add(todo);
      // Schedule notification if reminder date is set
      if (todo.reminderDate != null) {
        await scheduleTodoNotification(todo);
      }
      return TextConstants.addSuccess;
    } else {
      bloc.todoUpdateSink.add(todo);
      // Update notification if reminder date changed
      await updateTodoNotification(todo);
      return TextConstants.updateSuccess;
    }
  }

  /// يتحقق من الحقول ويرجع رسالة خطأ إذا في مشكلة
  static String? validateTaskFields({
    required String name,
    required String description,
    required String completeBy,
    required String priority,
  }) {
    // الخطوة 1: التحقق من الحقول الفارغة
    if ([
      name,
      description,
      completeBy,
      priority,
    ].any((field) => field.trim().isEmpty)) {
      return "Please fill all fields";
    }

    // الخطوة 2: تحقق مخصص لكل حقل
    if (HelperMethods.isInteger(name)) {
      return "Name must contain letters";
    }

    if (HelperMethods.isInteger(description)) {
      return "Description must contain letters";
    }

    if (HelperMethods.isInteger(completeBy)) {
      return "Complete By must contain letters";
    }

    // ✅ التحقق أن Priority رقم صحيح
    if (!isInteger(priority)) {
      return TextConstants.errorOccurredInvalidPriority;
    }

    // ✅ التحقق أن Priority > 0
    final parsedPriority = int.parse(priority);
    if (parsedPriority <= 0) {
      return "Priority must be a number greater than 0";
    }

    return null; // ✅ يعني الحقول كلها صحيحة
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

  // ===== DATE AND TIME HELPER METHODS =====

  /// Check if a todo is overdue
  static bool isTodoOverdue(Todo todo) {
    if (todo.endDate == null || todo.isCompleted) return false;
    return DateTime.now().isAfter(todo.endDate!);
  }

  /// Check if a todo is due today
  static bool isTodoDueToday(Todo todo) {
    if (todo.endDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDate = DateTime(
      todo.endDate!.year,
      todo.endDate!.month,
      todo.endDate!.day,
    );
    return today.isAtSameMomentAs(dueDate);
  }

  /// Check if a todo is due soon (within 24 hours)
  static bool isTodoDueSoon(Todo todo) {
    if (todo.endDate == null || todo.isCompleted) return false;
    final now = DateTime.now();
    final difference = todo.endDate!.difference(now);
    return difference.inHours <= 24 && difference.inHours > 0;
  }

  /// Get human-readable status text for a todo
  static String getTodoStatusText(Todo todo) {
    if (todo.isCompleted) return TextConstants.completedStatus;
    if (isTodoOverdue(todo)) return TextConstants.overdueStatus;
    if (isTodoDueToday(todo)) return TextConstants.dueTodayStatus;
    if (isTodoDueSoon(todo)) return TextConstants.dueSoonStatus;
    return TextConstants.pendingStatus;
  }

  /// Format date for display
  static String formatDate(DateTime? date) {
    if (date == null) return 'Not set';
    return '${date.day}/${date.month}/${date.year}';
  }

  /// Format time for display
  static String formatTime(DateTime? date) {
    if (date == null) return 'Not set';
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  /// Format date and time for display
  static String formatDateTime(DateTime? date) {
    if (date == null) return 'Not set';
    return '${formatDate(date)} ${formatTime(date)}';
  }

  /// Get relative time string (e.g., "2 hours ago", "in 3 days")
  static String getRelativeTime(DateTime? date) {
    if (date == null) return 'Not set';

    final now = DateTime.now();
    final difference = date.difference(now);

    if (difference.isNegative) {
      // Past
      final absDifference = difference.abs();
      if (absDifference.inDays > 0) {
        return '${absDifference.inDays} day${absDifference.inDays == 1 ? '' : 's'} ago';
      } else if (absDifference.inHours > 0) {
        return '${absDifference.inHours} hour${absDifference.inHours == 1 ? '' : 's'} ago';
      } else {
        return '${absDifference.inMinutes} minute${absDifference.inMinutes == 1 ? '' : 's'} ago';
      }
    } else {
      // Future
      if (difference.inDays > 0) {
        return 'in ${difference.inDays} day${difference.inDays == 1 ? '' : 's'}';
      } else if (difference.inHours > 0) {
        return 'in ${difference.inHours} hour${difference.inHours == 1 ? '' : 's'}';
      } else {
        return 'in ${difference.inMinutes} minute${difference.inMinutes == 1 ? '' : 's'}';
      }
    }
  }

  /// Check if a date is today
  static bool isToday(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if a date is tomorrow
  static bool isTomorrow(DateTime? date) {
    if (date == null) return false;
    final tomorrow = DateTime.now().add(Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Check if a date is this week
  static bool isThisWeek(DateTime? date) {
    if (date == null) return false;
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));
    return date.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
        date.isBefore(endOfWeek.add(Duration(days: 1)));
  }

  // Notification handling methods
  static final NotificationService _notificationService = NotificationService();

  /// Schedule notification for a todo reminder
  static Future<void> scheduleTodoNotification(Todo todo) async {
    if (todo.reminderDate == null) return;

    // Generate notification ID if not exists
    todo.notificationId ??= todo.generateNotificationId();

    // Schedule the notification
    await _notificationService.scheduleTodoReminder(todo);
  }

  /// Cancel notification for a todo
  static Future<void> cancelTodoNotification(Todo todo) async {
    if (todo.notificationId != null) {
      await _notificationService.cancelNotification(todo.notificationId!);
    }
  }

  /// Update notification when todo is modified
  static Future<void> updateTodoNotification(Todo todo) async {
    // Cancel existing notification
    await cancelTodoNotification(todo);

    // Schedule new notification if reminder date exists
    if (todo.reminderDate != null) {
      await scheduleTodoNotification(todo);
    }
  }

  /// Show beautiful status notification using Flushbar
  static void showTodoStatusNotification(
    BuildContext context,
    bool isCompleted,
  ) {
    _showFlushbar(
      context: context,
      message: isCompleted
          ? TextConstants.taskCompletedMessage
          : TextConstants.taskUncompletedMessage,
      backgroundColor: isCompleted
          ? Colors.green.withValues(alpha: 0.95)
          : Colors.red.withValues(alpha: 0.95),
      icon: isCompleted ? Icons.check_circle : Icons.cancel,
      duration: Duration(seconds: 2),
    );
  }
}
