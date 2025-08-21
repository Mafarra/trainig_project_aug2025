import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/core/constants/theme_constants.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';

class AppWidgets {
  // This class can be used to define common widgets used across the app.
  // Currently, it is empty but can be extended in the future.
  static Widget dismissibleWrapper({
    required Widget child,
    required Key key,
    required BuildContext context,
    required VoidCallback onDelete,
  }) {
    return Dismissible(
      key: key,
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async =>
          await HelperMethods.showDeleteConfirmationDialog(context),
      onDismissed: (_) {
        onDelete();
        // Note: onDelete callback should handle its own context.mounted check
      },
      child: child,
    );
  }

  /// A reusable custom text field widget
  static Widget customTextField({
    required TextEditingController controller,
    required String hintText,
    double padding = SizeConstants.paddingXL,
    TextInputType? keyboardType,
    InputBorder? border,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    int? maxLines = 1,
    int? maxLength,
    String? Function(String?)? validator,
    void Function(String)? onChanged,
    void Function()? onTap,
    bool enabled = true,
    bool readOnly = false,
    FocusNode? focusNode,
  }) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        maxLength: maxLength,
        onChanged: onChanged,
        onTap: onTap,
        enabled: enabled,
        readOnly: readOnly,
        focusNode: focusNode,
        decoration: InputDecoration(
          border: border ?? InputBorder.none,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  /// A reusable padded widget for consistent spacing
  static Widget appPadded({
    required Widget child,
    double all = SizeConstants.paddingXL,
    EdgeInsets? padding,
  }) {
    return Padding(padding: padding ?? EdgeInsets.all(all), child: child);
  }

  /// A reusable date picker widget
  static Widget customDatePicker({
    required String label,
    required DateTime? selectedDate,
    required Function(DateTime?) onDateSelected,
    required State state,
  }) {
    final isDark = Theme.of(state.context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.all(SizeConstants.paddingXL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ThemeConstants.getTextPrimaryColor(isDark),
            ),
          ),
          SizedBox(height: SizeConstants.spacingS),
          InkWell(
            onTap: () async {
              if (!state.mounted) return;
              final DateTime? picked = await showDatePicker(
                context: state.context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 365)),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: isDark
                          ? ColorScheme.dark(
                              primary: AppColors.primary,
                              onPrimary: AppColors.white,
                              surface: ThemeConstants.darkSurface,
                              onSurface: ThemeConstants.darkTextPrimary,
                            )
                          : ColorScheme.light(
                              primary: AppColors.primary,
                              onPrimary: AppColors.white,
                              surface: ThemeConstants.lightSurface,
                              onSurface: ThemeConstants.lightTextPrimary,
                            ),
                    ),
                    child: child!,
                  );
                },
              );
              if (picked != null) {
                // For reminder, also show time picker
                if (label == TextConstants.reminderDateLabel) {
                  if (!state.mounted) return;
                  final TimeOfDay? pickedTime = await showTimePicker(
                    context: state.context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: AppColors.primary,
                            onPrimary: AppColors.white,
                            surface: AppColors.surface,
                            onSurface: AppColors.textPrimary,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedTime != null) {
                    final combinedDateTime = DateTime(
                      picked.year,
                      picked.month,
                      picked.day,
                      pickedTime.hour,
                      pickedTime.minute,
                    );
                    onDateSelected(combinedDateTime);
                  }
                } else {
                  onDateSelected(picked);
                }
              }
            },
            child: Container(
              padding: EdgeInsets.all(SizeConstants.paddingL),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ThemeConstants.getDividerColor(isDark),
                ),
                borderRadius: BorderRadius.circular(SizeConstants.radiusS),
                color: ThemeConstants.getSurfaceColor(isDark),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  SizedBox(width: SizeConstants.spacingS),
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? HelperMethods.formatDateTime(selectedDate)
                          : TextConstants.selectDate,
                      style: TextStyle(
                        color: selectedDate != null
                            ? ThemeConstants.getTextPrimaryColor(isDark)
                            : ThemeConstants.getTextSecondaryColor(isDark),
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ThemeConstants.getTextSecondaryColor(isDark),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// A reusable status chip widget for todo items
  static Widget todoStatusChip({
    required bool isCompleted,
    required bool isOverdue,
    required bool isDueToday,
    required bool isDueSoon,
    BuildContext? context,
  }) {
    final isDark = context != null
        ? Theme.of(context).brightness == Brightness.dark
        : false;
    Color chipColor;
    String statusText;
    IconData statusIcon;

    if (isCompleted) {
      chipColor = AppColors.success;
      statusText = TextConstants.completedStatus;
      statusIcon = Icons.check_circle;
    } else if (isOverdue) {
      chipColor = AppColors.error;
      statusText = TextConstants.overdueStatus;
      statusIcon = Icons.warning;
    } else if (isDueToday) {
      chipColor = AppColors.warning;
      statusText = TextConstants.dueTodayStatus;
      statusIcon = Icons.today;
    } else if (isDueSoon) {
      chipColor = AppColors.accent;
      statusText = TextConstants.dueSoonStatus;
      statusIcon = Icons.schedule;
    } else {
      chipColor = isDark ? ThemeConstants.gray600 : AppColors.gray400;
      statusText = TextConstants.pendingStatus;
      statusIcon = Icons.pending;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConstants.paddingS,
        vertical: SizeConstants.paddingXS,
      ),
      decoration: BoxDecoration(
        color: chipColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(SizeConstants.radiusS),
        border: Border.all(color: chipColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(statusIcon, size: 14, color: chipColor),
          SizedBox(width: SizeConstants.spacingXS),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: chipColor,
            ),
          ),
        ],
      ),
    );
  }

  /// A reusable date info widget for todo items
  static Widget todoDateInfo({
    required DateTime? startDate,
    required DateTime? endDate,
    required DateTime? reminderDate,
    required bool isOverdue,
    required bool isCompleted,
  }) {
    final List<Widget> dateWidgets = [];

    // Add start date if available
    if (startDate != null) {
      dateWidgets.add(
        todoDateRow(
          Icons.play_arrow,
          'Start: ${HelperMethods.formatDate(startDate)}',
          AppColors.primary,
        ),
      );
    }

    // Add end date if available
    if (endDate != null) {
      dateWidgets.add(
        todoDateRow(
          Icons.flag,
          'Due: ${HelperMethods.formatDate(endDate)}',
          isOverdue ? AppColors.error : AppColors.textSecondary,
        ),
      );
    }

    // Add reminder date if available
    if (reminderDate != null) {
      dateWidgets.add(
        todoDateRow(
          Icons.notifications,
          'Reminder: ${HelperMethods.formatDateTime(reminderDate)}',
          AppColors.accent,
        ),
      );
    }

    // Add relative time info
    if (endDate != null && !isCompleted) {
      final relativeTime = HelperMethods.getRelativeTime(endDate);
      if (relativeTime.isNotEmpty) {
        dateWidgets.add(
          todoDateRow(
            Icons.access_time,
            relativeTime,
            isOverdue ? AppColors.error : AppColors.textSecondary,
          ),
        );
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: dateWidgets,
    );
  }

  /// A reusable date row widget for todo items
  static Widget todoDateRow(IconData icon, String text, Color color) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConstants.spacingXS),
      child: Row(
        children: [
          Icon(icon, size: 12, color: color),
          SizedBox(width: SizeConstants.spacingXS),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 12, color: color)),
          ),
        ],
      ),
    );
  }
}
