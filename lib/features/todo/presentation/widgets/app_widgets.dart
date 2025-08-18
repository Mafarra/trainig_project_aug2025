
import 'package:flutter/material.dart';
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
    confirmDismiss: (_) async => await HelperMethods.showDeleteConfirmationDialog(context),
    onDismissed: (_) => onDelete(),
    child: child,
  );
}

}