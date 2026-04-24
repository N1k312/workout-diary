import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.bgPrimary,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accentPrimary,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.interTextTheme(
          TextTheme(
            displayLarge: AppTextStyles.displayLarge,
            headlineLarge: AppTextStyles.headlineLarge,
            headlineMedium: AppTextStyles.headlineMedium,
            titleLarge: AppTextStyles.titleLarge,
            titleMedium: AppTextStyles.titleMedium,
            bodyLarge: AppTextStyles.bodyLarge,
            bodyMedium: AppTextStyles.bodyMedium,
            bodySmall: AppTextStyles.bodySmall,
            labelSmall: AppTextStyles.labelSmall,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.bgPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      );
}
