import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Cuba Groceries — Premium ThemeData
/// DM Sans for headings, Inter for body. Warm earthy palette.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final baseText = GoogleFonts.interTextTheme();
    final headingText = GoogleFonts.dmSansTextTheme();

    final textTheme = baseText.copyWith(
      displayLarge: headingText.displayLarge?.copyWith(color: AppColors.textPrimary),
      displayMedium: headingText.displayMedium?.copyWith(color: AppColors.textPrimary),
      displaySmall: headingText.displaySmall?.copyWith(color: AppColors.textPrimary),
      headlineLarge: headingText.headlineLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.8,
      ),
      headlineMedium: headingText.headlineMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
      ),
      headlineSmall: headingText.headlineSmall?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
      titleLarge: headingText.titleLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      titleMedium: headingText.titleMedium?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: headingText.titleSmall?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: baseText.bodyLarge?.copyWith(color: AppColors.textPrimary, height: 1.5),
      bodyMedium: baseText.bodyMedium?.copyWith(color: AppColors.textPrimary, height: 1.5),
      bodySmall: baseText.bodySmall?.copyWith(color: AppColors.textSecondary, height: 1.4),
      labelLarge: baseText.labelLarge?.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
      labelMedium: baseText.labelMedium?.copyWith(color: AppColors.textSecondary),
      labelSmall: baseText.labelSmall?.copyWith(color: AppColors.textSecondary),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      textTheme: textTheme,

      // Colors
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.textOnPrimary,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        surface: AppColors.cardBg,
        error: AppColors.error,
      ),

      scaffoldBackgroundColor: AppColors.scaffoldBg,

      // AppBar — Borderless, warm background
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.scaffoldBg,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: GoogleFonts.dmSans(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -0.3,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size: 22,
        ),
      ),

      // Cards — No elevation, subtle border
      cardTheme: CardThemeData(
        color: AppColors.cardBg,
        elevation: 0,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: AppColors.border, width: 0.5),
        ),
        margin: EdgeInsets.zero,
      ),

      // Elevated Button — Rounded, no shadow
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),

      // Outlined Button — Thin border
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          side: const BorderSide(color: AppColors.primary, width: 1.2),
          textStyle: GoogleFonts.dmSans(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Text Button
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // Input Decoration — Softer, warmer
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: TextStyle(
          color: AppColors.textHint,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        labelStyle: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Bottom Navigation — Clean, borderless
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.cardBg,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 11),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 0.5,
        space: 0.5,
      ),

      // Chip — Warm, pill-shaped
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.accentLight,
        selectedColor: AppColors.primary,
        labelStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      ),

      // Icon theme
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: 22,
      ),

      // Progress indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
    );
  }
}
