import 'package:flutter/material.dart';

class AppTheme {
  // Colors from the image
  static const Color background = Color(0xFF19202E);
  static const Color sidebarBackground = Color(0xFF222B3B);
  static const Color cardBackground = Color(0xFF222B3B);
  static const Color textPrimary = Color(0xFFE2E8F0);
  static const Color textSecondary = Color(0xFF94A3B8);

  static const Color primaryTeal = Color(0xFF2DD4BF);
  static const Color alertRed = Color(0xFFEF4444);

  static const Color border = Color(0xFF334155);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: primaryTeal,
      fontFamily: 'Inter', // Or similar sans-serif
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textPrimary),
        bodyMedium: TextStyle(color: textSecondary),
        titleLarge: TextStyle(color: textPrimary, fontWeight: FontWeight.bold),
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: border),
        ),
      ),
      dividerColor: border,
    );
  }
}
