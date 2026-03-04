import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Asif Groceries — Elegant text styles
/// Uses DM Sans (headings) + Inter (body) via Google Fonts loaded in AppTheme
class AppTextStyles {
  AppTextStyles._();

  // Headings — DM Sans
  static const TextStyle h1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.8,
    height: 1.2,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
    height: 1.25,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.3,
  );

  static const TextStyle h4 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    letterSpacing: -0.2,
  );

  // Body — Inter
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4,
  );

  // Labels
  static const TextStyle labelLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    letterSpacing: 0.1,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.1,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    letterSpacing: 0.2,
  );

  // Button
  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.3,
  );

  // Caption
  static const TextStyle caption = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    letterSpacing: 0.2,
  );

  // Price
  static const TextStyle price = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    letterSpacing: -0.3,
  );

  static const TextStyle priceSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static const TextStyle priceStrikethrough = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
    decoration: TextDecoration.lineThrough,
  );
}
