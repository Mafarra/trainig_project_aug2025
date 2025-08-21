import 'package:flutter/material.dart';
import 'package:trainig_project_aug2025/blocs/theme_bloc.dart';
import 'package:trainig_project_aug2025/core/constants/app_colors.dart';
import 'package:trainig_project_aug2025/core/constants/theme_constants.dart';
import 'package:trainig_project_aug2025/features/todo/presentation/pages/home_page.dart';
import 'package:trainig_project_aug2025/services/notification_service.dart';
import 'package:trainig_project_aug2025/services/theme_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize notification service
  await NotificationService().initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeBloc _themeBloc = ThemeBloc();

  @override
  void dispose() {
    _themeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppThemeMode>(
      stream: _themeBloc.themeMode,
      builder: (context, snapshot) {
        final themeMode = snapshot.data ?? AppThemeMode.system;

        return MaterialApp(
          theme: _getLightTheme(),
          darkTheme: _getDarkTheme(),
          themeMode: _getThemeMode(themeMode),
          title: 'Todos App',
          debugShowCheckedModeBanner: false,
          home: HomePage(themeBloc: _themeBloc),
        );
      },
    );
  }

  ThemeMode _getThemeMode(AppThemeMode appThemeMode) {
    switch (appThemeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }

  ThemeData _getLightTheme() {
    return ThemeData(
      brightness: Brightness.light,
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
      scaffoldBackgroundColor: ThemeConstants.lightBackground,
      cardColor: ThemeConstants.lightCardBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: ThemeConstants.lightTextPrimary),
        bodyMedium: TextStyle(color: ThemeConstants.lightTextPrimary),
        bodySmall: TextStyle(color: ThemeConstants.lightTextSecondary),
        titleLarge: TextStyle(color: ThemeConstants.lightTextPrimary),
        titleMedium: TextStyle(color: ThemeConstants.lightTextPrimary),
        titleSmall: TextStyle(color: ThemeConstants.lightTextPrimary),
      ),
      dividerTheme: DividerThemeData(
        color: ThemeConstants.lightDivider,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: ThemeConstants.lightCardBackground,
        elevation: 2,
        shadowColor: AppColors.shadow,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeConstants.lightSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeConstants.lightDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeConstants.lightDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        labelStyle: TextStyle(color: ThemeConstants.lightTextSecondary),
        hintStyle: TextStyle(color: ThemeConstants.lightTextDisabled),
      ),
    );
  }

  ThemeData _getDarkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
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
      scaffoldBackgroundColor: ThemeConstants.darkBackground,
      cardColor: ThemeConstants.darkCardBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: ThemeConstants.darkSurface,
        foregroundColor: ThemeConstants.darkTextPrimary,
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: ThemeConstants.darkTextPrimary),
        bodyMedium: TextStyle(color: ThemeConstants.darkTextPrimary),
        bodySmall: TextStyle(color: ThemeConstants.darkTextSecondary),
        titleLarge: TextStyle(color: ThemeConstants.darkTextPrimary),
        titleMedium: TextStyle(color: ThemeConstants.darkTextPrimary),
        titleSmall: TextStyle(color: ThemeConstants.darkTextPrimary),
      ),
      dividerTheme: DividerThemeData(
        color: ThemeConstants.darkDivider,
        thickness: 1,
      ),
      cardTheme: CardThemeData(
        color: ThemeConstants.darkCardBackground,
        elevation: 2,
        shadowColor: AppColors.shadow,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ThemeConstants.darkSurface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeConstants.darkDivider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: ThemeConstants.darkDivider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: AppColors.primary),
        ),
        labelStyle: TextStyle(color: ThemeConstants.darkTextSecondary),
        hintStyle: TextStyle(color: ThemeConstants.darkTextDisabled),
      ),
    );
  }
}
