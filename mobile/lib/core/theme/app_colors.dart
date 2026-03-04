import 'package:flutter/material.dart';

/// Asif Groceries — AG Logo-Derived Palette
/// Deep emerald green (#03613D) as dominant primary,
/// lime green (basket/leaf), mango orange (fruits).
class AppColors {
  AppColors._();

  // ── Primary — Deep emerald green (dominant brand color) ──
  static const Color primary = Color(0xFF03613D);
  static const Color primaryDark = Color(0xFF024A2E);
  static const Color primaryLight = Color(0xFF1A8B5A);
  static const Color primarySurface = Color(0xFFE3F5ED);

  // ── Accent — Mango orange (from logo fruits) ──
  static const Color accent = Color(0xFFF5A623);
  static const Color accentLight = Color(0xFFFFF4E0);
  static const Color accentDark = Color(0xFFE08A0C);

  // ── Secondary — Lime green (from logo basket & leaf) ──
  static const Color secondary = Color(0xFF7CB342);
  static const Color secondaryLight = Color(0xFFF0F8E8);
  static const Color secondaryDark = Color(0xFF5C8A2F);

  // ── Background — Warm, natural whites ──
  static const Color scaffoldBg = Color(0xFFF7F9F5);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surfaceBg = Color(0xFFEDF3EB);

  // ── Text — Green-tinted neutrals for hierarchy ──
  static const Color textPrimary = Color(0xFF1A2E1A);
  static const Color textSecondary = Color(0xFF5A6B5A);
  static const Color textHint = Color(0xFF9CAA9C);
  static const Color textOnPrimary = Colors.white;

  // ── Status ──
  static const Color success = Color(0xFF2E9E5A);
  static const Color error = Color(0xFFD14343);
  static const Color warning = Color(0xFFF5A623);
  static const Color info = Color(0xFF3A86A8);

  // ── Borders & Dividers ──
  static const Color border = Color(0xFFDDE5D8);
  static const Color divider = Color(0xFFEAF0E5);

  // ── Shadows ──
  static const Color shadow = Color(0x0D1A3A1A);
  static const Color shadowMedium = Color(0x1A1A3A1A);

  // ── Ratings ──
  static const Color ratingStar = Color(0xFFF5A623);

  // ── Order status ──
  static const Color statusPending = Color(0xFFF5A623);
  static const Color statusConfirmed = Color(0xFF3A86A8);
  static const Color statusDispatched = Color(0xFF7B68A6);
  static const Color statusDelivered = Color(0xFF2E9E5A);
  static const Color statusCancelled = Color(0xFFD14343);
}
