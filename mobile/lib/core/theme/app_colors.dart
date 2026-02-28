import 'package:flutter/material.dart';

/// Cuba Groceries color palette
/// Inspired by ProKit Grocery theme, adapted for Cuba Groceries branding
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF4CAF50);       // Green
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFFC8E6C9);
  static const Color primarySurface = Color(0xFFE8F5E9);

  // Accent
  static const Color accent = Color(0xFFFF9800);         // Orange
  static const Color accentLight = Color(0xFFFFF3E0);

  // Background
  static const Color scaffoldBg = Color(0xFFF5F5F5);
  static const Color cardBg = Colors.white;
  static const Color surfaceBg = Color(0xFFFAFAFA);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Colors.white;

  // Status
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);

  // Borders & Dividers
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // Shadows
  static const Color shadow = Color(0x1A000000);

  // Ratings
  static const Color ratingStar = Color(0xFFFFC107);

  // Order status
  static const Color statusPending = Color(0xFFFF9800);
  static const Color statusConfirmed = Color(0xFF2196F3);
  static const Color statusDispatched = Color(0xFF9C27B0);
  static const Color statusDelivered = Color(0xFF4CAF50);
  static const Color statusCancelled = Color(0xFFF44336);
}
