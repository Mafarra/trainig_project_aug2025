import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/theme_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/services/theme_service.dart';

class AnimatedThemeToggle extends StatelessWidget {
  final ThemeBloc themeBloc;

  const AnimatedThemeToggle({super.key, required this.themeBloc});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppThemeMode>(
      stream: themeBloc.themeMode,
      builder: (context, snapshot) {
        final isDark = snapshot.data == AppThemeMode.dark;

        return GestureDetector(
          onTap: () async {
            await themeBloc.setThemeMode(
              isDark ? AppThemeMode.light : AppThemeMode.dark,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 60,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: isDark
                    ? [AppColors.primary, AppColors.primaryDark]
                    : [AppColors.gray300, AppColors.gray400],
              ),
            ),
            child: Stack(
              children: [
                // Background icons
                Positioned(
                  left: 6,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: isDark ? 0.0 : 1.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.light_mode,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 0,
                  bottom: 0,
                  child: Center(
                    child: AnimatedOpacity(
                      opacity: isDark ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.dark_mode,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),

                // Sliding thumb with dynamic icon
                AnimatedAlign(
                  duration: const Duration(milliseconds: 300),
                  alignment: isDark
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withValues(alpha: 0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        isDark ? Icons.dark_mode : Icons.light_mode,
                        size: 14,
                        color: isDark ? AppColors.primary : AppColors.gray600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
