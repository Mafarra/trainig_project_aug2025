import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:trainig_project_aug2025/models/todo.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    try {
      // Initialize timezone
      tz.initializeTimeZones();

      // Android settings
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      // iOS settings
      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
          );

      // Initialize settings
      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Initialize the plugin
      await _notifications.initialize(
        settings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );
    } catch (e) {
      // Handle initialization errors gracefully
      print('Notification service initialization failed: $e');
    }
  }

  void _onNotificationTapped(NotificationResponse response) {
    // Handle notification tap
    // You can navigate to specific todo or show details
    print('Notification tapped: ${response.payload}');
  }

  Future<void> scheduleTodoReminder(Todo todo) async {
    try {
      if (todo.reminderDate == null || todo.notificationId == null) return;

      // Cancel existing notification if any
      await cancelNotification(todo.notificationId!);

      // Schedule new notification
      final notificationId =
          int.tryParse(todo.notificationId!) ??
          DateTime.now().millisecondsSinceEpoch;

      final scheduledTime = tz.TZDateTime.from(todo.reminderDate!, tz.local);

      print('Scheduling notification:');
      print('  - ID: $notificationId');
      print('  - Title: Todo Reminder');
      print('  - Body: ${todo.name}: ${todo.description}');
      print('  - Scheduled for: $scheduledTime');

      await _notifications.zonedSchedule(
        notificationId,
        'Todo Reminder',
        '${todo.name}: ${todo.description}',
        scheduledTime,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'todo_reminders',
            'Todo Reminders',
            channelDescription: 'Notifications for todo reminders',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: todo.id.toString(),
      );
    } catch (e) {
      print('Failed to schedule notification: $e');
    }
  }

  Future<void> cancelNotification(String notificationId) async {
    final id = int.tryParse(notificationId);
    if (id != null) {
      await _notifications.cancel(id);
    }
  }

  Future<void> cancelAllNotifications() async {
    await _notifications.cancelAll();
  }

  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    return await _notifications.pendingNotificationRequests();
  }
}
