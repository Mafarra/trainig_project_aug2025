class TextConstants {
  // Labels for TextFields
  static const String appTitle = 'Todo List';
  static const String nameLabel = 'Name';
  static const String descriptionLabel = 'Description';
  static const String completeByLabel = 'Complete By';
  static const String priorityLabel = 'Priority';
  static const String saveSuccess = 'تمت عملية الحفظ بنجاح';
  static const String addSuccess = 'تمت عملية الإضافة بنجاح';
  static const String updateSuccess = 'تم تحديث البيانات بنجاح';
  static const String deleteSuccess = 'تم الحذف بنجاح';
  static const String errorOccurredSave = 'حدث خطأ أثناء الحفظ';
  static const String errorOccurredUpdate = 'حدث خطأ أثناء التحديث';
  static const String errorOccurredDelete = 'حدث خطأ أثناء الحذف';
  static const String errorOccurredFetch = 'حدث خطأ أثناء جلب البيانات';
  static const String errorOccurredEmptyFields = 'الرجاء ملء كل الحقول';
  static const String errorOccurredInvalidPriority =
      'الرجاء إدخال أولوية صحيحة';
  static const String errorOccurredInvalidEmail = 'البريد الإلكتروني غير صالح';
  static const String errorOccurredInvalidInput = 'الرجاء إدخال قيمة صحيحة';
  static const String deleteConfirmationTitle = 'تأكيد الحذف';
  static const String deleteConfirmationMessage =
      'هل أنت متأكد أنك تريد حذف هذه المهمة؟';
  static const String cancel = 'إلغاء';
  static const String delete = 'حذف';
  static const String emptyTasks = "لا توجد مهام حالياً";

  // Buttons
  static const String saveButton = 'Save';

  // Error messages
  static const String emptyFieldsError = 'Please fill in all fields';
  static const String invalidPriorityError = 'Priority must be a number';

  // Navigation / Misc
  static const String homePageTitle = 'Home';

  // Unmounted context messages
  static const String saveSuccessNavigationError =
      'تم الحفظ بنجاح، لكن حدث خطأ في التنقل. الرجاء العودة للصفحة الرئيسية يدوياً.';

  // Refresh messages
  static const String refreshSuccess = 'تم تحديث القائمة بنجاح';
  static const String refreshError = 'حدث خطأ أثناء تحديث القائمة';

  // Date and time labels
  static const String startDateLabel = 'Start Date';
  static const String endDateLabel = 'End Date';
  static const String reminderDateLabel = 'Reminder';
  static const String dueDateLabel = 'Due Date';

  // Status messages
  static const String completedStatus = 'Completed';
  static const String overdueStatus = 'Overdue';
  static const String dueTodayStatus = 'Due Today';
  static const String dueSoonStatus = 'Due Soon';
  static const String pendingStatus = 'Pending';

  // Date picker messages
  static const String selectDate = 'Select Date';
  static const String selectTime = 'Select Time';
  static const String setReminder = 'Set Reminder';
  static const String noReminder = 'No Reminder';

  // Status notification messages
  static const String taskCompletedMessage = 'تم وضع المهمة كمكتملة';
  static const String taskUncompletedMessage = 'تم التراجع عن الإنجاز';
}
