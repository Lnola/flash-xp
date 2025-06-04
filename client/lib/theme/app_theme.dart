import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF120F11);
  static const Color surface = Color(0xFFEAEDEF);

  static const Color yellow = Color(0xFFFCE8AE);
  static const Color blue = Color(0xFF98BFF5);
  static const Color green = Color(0xFFCCEAB3);
  static const Color purple = Color(0xFFC3A8FC);
  static const Color red = Color(0xFFF5A7A4);
}

class AppTheme {
  static ThemeData get light {
    final base = ThemeData.light().textTheme;

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.surface,
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.blue,
        onPrimary: AppColors.black,
        secondary: AppColors.purple,
        onSecondary: AppColors.black,
        surface: AppColors.white,
        onSurface: AppColors.black,
        inverseSurface: AppColors.surface,
        onInverseSurface: AppColors.black,
        tertiary: AppColors.green,
        onTertiary: AppColors.black,
        error: AppColors.red,
        onError: AppColors.black,
        primaryContainer: AppColors.black,
        onPrimaryContainer: AppColors.white,
      ),
      textTheme: TextTheme(
        // Poppins W700
        displaySmall: GoogleFonts.poppins(
          textStyle: base.displaySmall?.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        // Poppins w500
        titleLarge: GoogleFonts.poppins(
          textStyle: base.titleLarge?.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: AppColors.black,
          ),
        ),
        // Poppins w400
        labelMedium: GoogleFonts.poppins(
          textStyle: base.labelMedium?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        // Inter W400
        bodySmall: GoogleFonts.inter(
          textStyle: base.bodySmall?.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
