import 'package:flutter/material.dart';

class AppColors {
  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF120F11);
  static const Color surface = Color(0xFFEAEDEF);

  // Brand Colors
  static const Color yellow = Color(0xFFFCE8AE);
  static const Color blue = Color(0xFF98BFF5);
  static const Color green = Color(0xFFCCEAB3);
  static const Color purple = Color(0xFFC3A8FC);
  static const Color red = Color(0xFFF5A7A4);
}

class AppTheme {
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.surface,
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.blue,
          onPrimary: AppColors.black,
          secondary: AppColors.purple,
          onSecondary: AppColors.black,
          surface: AppColors.white,
          onSurface: AppColors.black,
          error: AppColors.red,
          onError: AppColors.white,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          displaySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
          bodyLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          bodyMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
          labelSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
      );
}
