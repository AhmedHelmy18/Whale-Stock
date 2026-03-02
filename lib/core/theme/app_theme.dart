import 'package:flutter/material.dart';

class AppTheme {

  static const Color background = Color(0xFF19202E);
  static const Color sidebarBackground = Color(0xFF222B3B);
  static const Color cardBackground = Color(0xFF222B3B);
  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color primaryTeal = Color(0xFF2DD4BF);
  static const Color alertRed = Color(0xFFEF4444);
  static const Color border = Color(0xFF334155);


  static const Color success = Color(0xFF05CD99);
  static const Color error = Color(0xFFEE5D50);
}

class AppColors {

  static const Color primaryLight = Color(0xFF2E6FF2);
  static const Color secondaryLight = Color(0xFF1ABC9C);
  static const Color backgroundLight = Color(0xFFF4F7FE);
  static const Color cardLight = Colors.white;
  static const Color textMainLight = Color(0xFF2B3674);
  static const Color textSecondaryLight = Color(0xFFA3AED0);


  static const Color primaryDark = AppTheme.primaryTeal;
  static const Color secondaryDark = Color(0xFF00B5D8);
  static const Color backgroundDark = AppTheme.background;
  static const Color cardDark = AppTheme.cardBackground;
  static const Color textMainDark = AppTheme.textPrimary;
  static const Color textSecondaryDark = AppTheme.textSecondary;

  static const Color success = AppTheme.success;
  static const Color error = AppTheme.error;
}

const TextStyle _headingStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 24,
  fontFamily: 'Inter',
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  primaryColor: AppColors.primaryLight,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  cardTheme: CardThemeData(
    color: AppColors.cardLight,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  textTheme: const TextTheme(
    headlineMedium: _headingStyle,
    bodyLarge: TextStyle(color: AppColors.textMainLight),
    bodyMedium: TextStyle(color: AppColors.textSecondaryLight),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryLight,
    primary: AppColors.primaryLight,
    secondary: AppColors.secondaryLight,
    surface: AppColors.cardLight,
    error: AppColors.error,
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryDark,
  scaffoldBackgroundColor: AppColors.backgroundDark,
  cardTheme: CardThemeData(
    color: AppColors.cardDark,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: AppTheme.border),
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: _headingStyle,
    bodyLarge: TextStyle(color: AppColors.textMainDark),
    bodyMedium: TextStyle(color: AppColors.textSecondaryDark),
  ),
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primaryDark,
    brightness: Brightness.dark,
    primary: AppColors.primaryDark,
    secondary: AppColors.secondaryDark,
    surface: AppColors.cardDark,
    error: AppColors.error,
  ),
);
