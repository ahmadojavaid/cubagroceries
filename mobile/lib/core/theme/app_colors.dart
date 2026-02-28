import 'package:flutter/material.dart';

/// Cuba Groceries — Warm Orange Palette
/// Welcoming, vibrant tones inspired by fresh citrus and warm markets.
class AppColors {
  AppColors._();

  // Primary — Rich warm orange
  static const Color primary = Color(0xFFE8742A);
  static const Color primaryDark = Color(0xFFC45A1A);
  static const Color primaryLight = Color(0xFFF5A563);
  static const Color primarySurface = Color(0xFFFFF0E5);

  // Accent — Deep teal for contrast
  static const Color accent = Color(0xFF1A8A7D);
  static const Color accentLight = Color(0xFFE0F5F2);
  static const Color accentDark = Color(0xFF136B61);

  // Background — Warm cream tones
  static const Color scaffoldBg = Color(0xFFFAF7F4);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surfaceBg = Color(0xFFF5F0EB);

  // Text — Warm dark hierarchy
  static const Color textPrimary = Color(0xFF2C1810);
  static const Color textSecondary = Color(0xFF6B5E57);
  static const Color textHint = Color(0xFFADA39B);
  static const Color textOnPrimary = Colors.white;

  // Status
  static const Color success = Color(0xFF2E9E5A);
  static const Color error = Color(0xFFD14343);
  static const Color warning = Color(0xFFF0A830);
  static const Color info = Color(0xFF3A86A8);

  // Borders & Dividers — Warm neutral
  static const Color border = Color(0xFFE8E0D8);
  static const Color divider = Color(0xFFF0EAE3);

  // Shadows — Warm, diffused
  static const Color shadow = Color(0x0D4A2C17);
  static const Color shadowMedium = Color(0x1A4A2C17);

  // Ratings
  static const Color ratingStar = Color(0xFFF0A830);

  // Order status
  static const Color statusPending = Color(0xFFF0A830);
  static const Color statusConfirmed = Color(0xFF3A86A8);
  static const Color statusDispatched = Color(0xFF7B68A6);
  static const Color statusDelivered = Color(0xFF2E9E5A);
  static const Color statusCancelled = Color(0xFFD14343);
}
