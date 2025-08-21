import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
import 'package:trainig_project_aug2025/core/constants/theme_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/widgets/app_widgets.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';
import 'package:trainig_project_aug2025/models/todo.dart';

class TodoItem extends StatefulWidget {
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
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  void _toggleExpanded() {
    widget.bloc.todoUpdateSink.add(
      widget.todo.copyWith(isExpanded: !widget.todo.isExpanded),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dismissible(
      secondaryBackground: Container(
        color: AppColors.dismissibleSuccess,
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
          return await HelperMethods.showDeleteConfirmationDialog(
            widget.parentContext,
          );
        } else if (direction == DismissDirection.endToStart) {
          widget.bloc.todoUpdateSink.add(
            widget.todo.copyWith(isCompleted: !widget.todo.isCompleted),
          );
          HelperMethods.showTodoStatusNotification(
            widget.parentContext,
            !widget.todo.isCompleted,
          );
          return false;
        }
        return false;
      },
      key: Key(widget.todo.id.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (_) {
        widget.bloc.todoDeleteSink.add(widget.todo);
        if (widget.parentContext.mounted) {
          HelperMethods.showSuccess(
            widget.parentContext,
            TextConstants.deleteSuccess,
          );
        }
      },
      child: Column(
        children: [
          ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ReorderableDragStartListener(
                  index: widget.index,
                  child: Icon(
                    Icons.drag_handle,
                    color: ThemeConstants.getTextSecondaryColor(isDark),
                  ),
                ),
                SizedBox(width: SizeConstants.spacingS),
                CircleAvatar(
                  backgroundColor: AppColors.taskPriority,
                  child: Text(
                    "${widget.todo.priority}",
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
                    widget.todo.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: widget.todo.isCompleted
                          ? ThemeConstants.getTextDisabledColor(isDark)
                          : ThemeConstants.getTextPrimaryColor(isDark),
                      decoration: widget.todo.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
                AppWidgets.todoStatusChip(
                  isCompleted: widget.todo.isCompleted,
                  isOverdue: widget.todo.isOverdue,
                  isDueToday: widget.todo.isDueToday,
                  isDueSoon: widget.todo.isDueSoon,
                  context: context,
                ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.todo.description.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(bottom: SizeConstants.spacingXS),
                    child: Text(
                      widget.todo.description,
                      style: TextStyle(
                        color: ThemeConstants.getTextSecondaryColor(isDark),
                        fontSize: 14,
                      ),
                    ),
                  ),
                if (widget.todo.isExpanded)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: AppWidgets.todoDateInfo(
                      startDate: widget.todo.startDate,
                      endDate: widget.todo.endDate,
                      reminderDate: widget.todo.reminderDate,
                      isOverdue: widget.todo.isOverdue,
                      isCompleted: widget.todo.isCompleted,
                    ),
                  ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: widget.onEdit,
                ),
                IconButton(
                  icon: AnimatedRotation(
                    turns: widget.todo.isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: ThemeConstants.getTextSecondaryColor(isDark),
                    ),
                  ),
                  onPressed: _toggleExpanded,
                ),
              ],
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
