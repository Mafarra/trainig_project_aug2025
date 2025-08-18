import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/todo_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
import 'package:trainig_project_aug2025/core/constants/text_constants.dart';
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
    return Dismissible(
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: SizeConstants.paddingL),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: SizeConstants.paddingL),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      key: Key(todo.id.toString()),
      direction: DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        return await HelperMethods.showDeleteConfirmationDialog(parentContext);
      },
      onDismissed: (_) {
        bloc.todoDeleteSink.add(todo);
        HelperMethods.showError(parentContext, TextConstants.deleteSuccess);
      },
      child: ListTile(
        leading: Row(
          mainAxisSize: MainAxisSize.min, // حتى لا ياخذ كامل المسافة
          children: [
            ReorderableDragStartListener(
              index: index, // لازم تجيب الـ index من الـ ListView.builder
              child: Icon(Icons.drag_handle),
            ),
            SizedBox(
              width: SizeConstants.spacingS,
            ), // مسافة بين الأيقونة و الـ CircleAvatar
            CircleAvatar(
              backgroundColor: Theme.of(parentContext).highlightColor,
              child: Text("${todo.priority}"),
            ),
          ],
        ),
        title: Text(todo.name),
        subtitle: Text(todo.description),
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onEdit),
      ),
    );
  }
}
