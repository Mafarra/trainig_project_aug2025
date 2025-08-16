
import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/helpers/helpr_methods.dart';

class AnimationHelpers {
  static Duration defaultDuration = const Duration(milliseconds: 300);
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

static Widget animatedAppearance({
  required Widget child,
  required int index,
}) {
  return TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: Duration(milliseconds: 300 + (index * 50)),
    curve: Curves.easeOutCubic,
    builder: (context, value, child) {
      return Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 20),
          child: child,
        ),
      );
    },
    child: child,
  );
}


  static Widget shimmerTodoList({required int itemCount}) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade300,
                  Colors.grey.shade100,
                  Colors.grey.shade300,
                ],
                stops: [0.1, 0.5, 0.9],
                begin: Alignment(-1, -0.3),
                end: Alignment(1, 0.3),
              ),
            ),
            height: 70,
          ),
        );
      },
    );
  }

}