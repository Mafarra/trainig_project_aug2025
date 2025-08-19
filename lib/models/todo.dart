import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';

class Todo {
  int? id;
  String name;
  String description;
  String completeBy;
  int priority;

  // New date fields
  DateTime? startDate;
  DateTime? endDate;
  DateTime? reminderDate;

  // Status and notification fields
  bool isCompleted;
  String? notificationId;
  DateTime? completedAt;

  Todo(
    this.name,
    this.description,
    this.completeBy,
    this.priority, {
    this.startDate,
    this.endDate,
    this.reminderDate,
    this.isCompleted = false,
    this.notificationId,
    this.completedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'completeBy': completeBy,
      'priority': priority,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'reminderDate': reminderDate?.millisecondsSinceEpoch,
      'isCompleted': isCompleted ? 1 : 0,
      'notificationId': notificationId,
      'completedAt': completedAt?.millisecondsSinceEpoch,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      map['name'],
      map['description'],
      map['completeBy'],
      map['priority'],
      startDate: map['startDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startDate'])
          : null,
      endDate: map['endDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['endDate'])
          : null,
      reminderDate: map['reminderDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['reminderDate'])
          : null,
      isCompleted: map['isCompleted'] == 1,
      notificationId: map['notificationId'],
      completedAt: map['completedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['completedAt'])
          : null,
    );
  }

  // Helper getters that use HelperMethods
  bool get isOverdue => HelperMethods.isTodoOverdue(this);
  bool get isDueToday => HelperMethods.isTodoDueToday(this);
  bool get isDueSoon => HelperMethods.isTodoDueSoon(this);
  String get statusText => HelperMethods.getTodoStatusText(this);

  // Generate unique notification ID
  String generateNotificationId() {
    return '${id ?? DateTime.now().millisecondsSinceEpoch}';
  }

  // Copy with method for easy updates
  Todo copyWith({
    int? id,
    String? name,
    String? description,
    String? completeBy,
    int? priority,
    DateTime? startDate,
    DateTime? endDate,
    DateTime? reminderDate,
    bool? isCompleted,
    String? notificationId,
    DateTime? completedAt,
  }) {
    return Todo(
      name ?? this.name,
      description ?? this.description,
      completeBy ?? this.completeBy,
      priority ?? this.priority,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      reminderDate: reminderDate ?? this.reminderDate,
      isCompleted: isCompleted ?? this.isCompleted,
      notificationId: notificationId ?? this.notificationId,
      completedAt: completedAt ?? this.completedAt,
    )..id = id ?? this.id;
  }
}
