import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/core/constants/theme_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/widgets/app_widgets.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final TodoBloc bloc;
  final BuildContext parentContext;
  final VoidCallback onEdit;
  final int index;

  const TodoItem({
    super.key,
    required this.todo,
    required this.bloc,
    required this.parentContext,
    required this.onEdit,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      secondaryBackground: Container(
        color: AppColors.dismissibleSuccess, // أخضر أو أي لون يدل على الإنجاز
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: SizeConstants.paddingL),
        child: Icon(Icons.check, color: AppColors.dismissibleIcon),
      ),
      background: Container(
        color: AppColors.dismissibleError,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: SizeConstants.paddingL),
        child: Icon(Icons.delete, color: AppColors.dismissibleIcon),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          // السحب من اليسار لليمين → حذف
          return await HelperMethods.showDeleteConfirmationDialog(
            parentContext,
          );
        } else if (direction == DismissDirection.endToStart) {
          // السحب من اليمين لليسار → تم الإنجاز
          bloc.todoUpdateSink.add(
            todo.copyWith(isCompleted: !todo.isCompleted),
          );
          // عرض الإشعار
          HelperMethods.showTodoStatusNotification(
            parentContext,
            !todo.isCompleted,
          );
          return false; // لا نحذف العنصر
        }
        return false;
      },
      key: Key(todo.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        bloc.todoDeleteSink.add(todo);
        if (parentContext.mounted) {
          HelperMethods.showSuccess(parentContext, TextConstants.deleteSuccess);
        }
      },
      child: Column(
        children: [
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min, // حتى لا ياخذ كامل المسافة
              children: [
                ReorderableDragStartListener(
                  index: index, // لازم تجيب الـ index من الـ ListView.builder
                  child: Icon(
                    Icons.drag_handle,
                    color: ThemeConstants.getTextSecondaryColor(isDark),
                  ),
                ),
                SizedBox(
                  width: SizeConstants.spacingS,
                ), // مسافة بين الأيقونة و الـ CircleAvatar
                CircleAvatar(
                  backgroundColor: AppColors.taskPriority,
                  child: Text(
                    "${todo.priority}",
                    style: TextStyle(
                      color: ThemeConstants.getTextPrimaryColor(!isDark),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    todo.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: todo.isCompleted
                          ? ThemeConstants.getTextDisabledColor(isDark)
                          : ThemeConstants.getTextPrimaryColor(isDark),
                      decoration: todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                AppWidgets.todoStatusChip(
                  isCompleted: todo.isCompleted,
                  isOverdue: todo.isOverdue,
                  isDueToday: todo.isDueToday,
                  isDueSoon: todo.isDueSoon,
                  context: context,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (todo.description.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: SizeConstants.spacingXS),
                    child: Text(
                      todo.description,
                      style: TextStyle(
                        color: ThemeConstants.getTextSecondaryColor(isDark),
                        fontSize: 14,
                      ),
                    ),
                  ),
                AppWidgets.todoDateInfo(
                  startDate: todo.startDate,
                  endDate: todo.endDate,
                  reminderDate: todo.reminderDate,
                  isOverdue: todo.isOverdue,
                  isCompleted: todo.isCompleted,
                ),
              ],
            ),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
          ),
          Divider(
            height: SizeConstants.dividerThickness,
            thickness: SizeConstants.dividerThickness,
            color: AppColors.divider,
            indent: SizeConstants.paddingL,
            endIndent: SizeConstants.paddingL,
          ),
        ],
      ),
    );
  }
}
