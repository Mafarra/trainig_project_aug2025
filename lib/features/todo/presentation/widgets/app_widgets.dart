
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

class AppPaddedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final double padding;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final InputBorder? border;

  const AppPaddedTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.padding = 20.0,
    this.keyboardType,
    this.obscureText = false,
    this.maxLines = 1,
    this.minLines,
    this.textInputAction,
    this.onChanged,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        maxLines: maxLines,
        minLines: minLines,
        textInputAction: textInputAction,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: border ?? InputBorder.none,
          hintText: hint,
        ),
      ),
    );
  }
}