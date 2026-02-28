import 'package:flutter/material.dart';

/// Cuba Groceries — Premium Earthy Palette
/// Warm, organic tones inspired by fresh produce and natural markets.
class AppColors {
  AppColors._();

  // Primary — Deep sage green
  static const Color primary = Color(0xFF2D6A4F);
  static const Color primaryDark = Color(0xFF1B4332);
  static const Color primaryLight = Color(0xFF74C69D);
  static const Color primarySurface = Color(0xFFD8F3DC);

  // Accent — Warm terracotta
  static const Color accent = Color(0xFFD4A373);
  static const Color accentLight = Color(0xFFFAEDCD);
  static const Color accentDark = Color(0xFFA47148);

  // Background — Warm greys with subtle warmth
  static const Color scaffoldBg = Color(0xFFF4F1ED);
  static const Color cardBg = Color(0xFFFAF8F6);
  static const Color surfaceBg = Color(0xFFEFECE7);

  // Text — Warm charcoal hierarchy
  static const Color textPrimary = Color(0xFF2B2D2E);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFFB0B8C1);
  static const Color textOnPrimary = Colors.white;

  // Status
  static const Color success = Color(0xFF40916C);
  static const Color error = Color(0xFFCC444B);
  static const Color warning = Color(0xFFE09F3E);
  static const Color info = Color(0xFF3A86A8);

  // Borders & Dividers — Warm grey
  static const Color border = Color(0xFFDDD8D0);
  static const Color divider = Color(0xFFE6E2DB);

  // Shadows — Warm, diffused
  static const Color shadow = Color(0x0D3E2723);
  static const Color shadowMedium = Color(0x1A3E2723);

  // Ratings
  static const Color ratingStar = Color(0xFFE09F3E);

  // Order status
  static const Color statusPending = Color(0xFFE09F3E);
  static const Color statusConfirmed = Color(0xFF3A86A8);
  static const Color statusDispatched = Color(0xFF7B68A6);
  static const Color statusDelivered = Color(0xFF40916C);
  static const Color statusCancelled = Color(0xFFCC444B);
}
