import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';
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
      onDismissed: (_) => onDelete(),
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
}
