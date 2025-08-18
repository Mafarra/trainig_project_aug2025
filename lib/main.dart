import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: MaterialColor(AppColors.primary.toARGB32(), <int, Color>{
          50: AppColors.primaryLight,
          100: AppColors.primaryLight,
          200: AppColors.primaryLight,
          300: AppColors.primaryLight,
          400: AppColors.primary,
          500: AppColors.primary,
          600: AppColors.primary,
          700: AppColors.primaryDark,
          800: AppColors.primaryDark,
          900: AppColors.primaryDark,
        }),
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.appBarBackground,
          foregroundColor: AppColors.appBarForeground,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.floatingActionButton,
          foregroundColor: AppColors.floatingActionButtonIcon,
        ),
      ),
      title: 'Todos App',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
