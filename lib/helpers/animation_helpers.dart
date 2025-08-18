import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/core/constants/size_constants.dart';

class AnimationHelpers {
  static Duration defaultDuration = const Duration(milliseconds: 300);
  // ValueNotifier للتحكم بحجم الزر
  final ValueNotifier<double> fabScale = ValueNotifier(1.0);

  /// Returns a Clean Animated FAB with Scale/Bounce effect using ValueNotifier
  Widget animatedFAB({required VoidCallback onPressed, required Widget child}) {
    return ValueListenableBuilder<double>(
      valueListenable: fabScale,
      builder: (context, scale, _) {
        return Transform.scale(
          scale: scale,
          child: FloatingActionButton(
            tooltip: 'Add new task',
            onPressed: () {
              // تكبير الزر عند الضغط
              fabScale.value = 1.2;
              // بعد 150ms يرجع الحجم الطبيعي
              Future.delayed(Duration(milliseconds: 50), () {
                fabScale.value = 1.0;
              });

              // تنفيذ الـ onPressed المرسل
              // تأخير تنفيذ onPressed حتى ينتهي الانيميشن
              Future.delayed(Duration(milliseconds: 50), () {
                onPressed(); // فتح صفحة جديدة
              });
            },
            child: child,
          ),
        );
      },
    );
  }

  // ValueNotifier للتحكم بحجم زر الحفظ
  final ValueNotifier<double> saveButtonScale = ValueNotifier(1.0);

  Widget animatedSaveButton({
    required VoidCallback onPressed,
    required Widget child,
  }) {
    return ValueListenableBuilder<double>(
      valueListenable: saveButtonScale,
      builder: (context, scale, _) {
        return Transform.scale(
          scale: scale,
          child: MaterialButton(
            color: AppColors.buttonSuccess, // لون الزر
            onPressed: () {
              // تكبير الزر عند الضغط
              saveButtonScale.value = 1.2;

              // بعد 150ms يرجع الحجم الطبيعي
              Future.delayed(Duration(milliseconds: 150), () {
                saveButtonScale.value = 1.0;
              });

              // تنفيذ الـ onPressed المرسل بعد الانيميشن
              Future.delayed(Duration(milliseconds: 160), () {
                onPressed();
              });
            },
            child: child,
          ),
        );
      },
    );
  }

  static Future<void> navigateWithAnimation({
    required BuildContext context,
    required Widget page,
  }) async {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation =
              Tween<Offset>(
                begin: Offset(0, -0.3), // يبدأ من أعلى
                end: Offset.zero,
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOut, // تأثير سلس
                ),
              );
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
      ),
    );
  }

  static Widget animatedAppearance({
    required Widget child,
    required int index,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 50 + (index * 50)),
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
          padding: EdgeInsets.symmetric(
            horizontal: SizeConstants.paddingL,
            vertical: SizeConstants.spacingS,
          ),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 800),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SizeConstants.radiusM),
              gradient: LinearGradient(
                colors: [
                  AppColors.shimmerBase,
                  AppColors.shimmerHighlight,
                  AppColors.shimmerEnd,
                ],
                stops: [0.1, 0.5, 0.9],
                begin: Alignment(-1, -0.3),
                end: Alignment(1, 0.3),
              ),
            ),
            height: SizeConstants.textFieldHeightL,
          ),
        );
      },
    );
  }

  static animatedTodoItem({required Widget child, required int index}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero),
      duration: Duration(milliseconds: 100),
      curve: Curves.easeOut,
      builder: (context, Offset offset, childWidget) {
        return Transform.translate(
          offset: Offset(0, offset.dy * 50), // تحريك من الأسفل
          child: Opacity(
            opacity: 1 - offset.dy, // Fade
            child: childWidget,
          ),
        );
      },
      child: child,
    );
  }
}
