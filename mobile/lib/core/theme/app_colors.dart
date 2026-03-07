import 'package:flutter/material.dart';

/// Asif Groceries — Orange-Dominant Palette
/// Vibrant orange (#F15722) as primary brand color,
/// warm tones throughout for energy and appetite appeal.
class AppColors {
  AppColors._();

  // ── Primary — Vibrant orange (dominant brand color) ──
  static const Color primary = Color(0xFFF15722);
  static const Color primaryDark = Color(0xFFD14A1C);
  static const Color primaryLight = Color(0xFFFF7A4D);
  static const Color primarySurface = Color(0xFFFFF0EB);

  // ── Accent — Deep emerald green (complementary) ──
  static const Color accent = Color(0xFF2E7D32);
  static const Color accentLight = Color(0xFFE8F5E9);
  static const Color accentDark = Color(0xFF1B5E20);

  // ── Secondary — Warm amber (supporting warmth) ──
  static const Color secondary = Color(0xFFF59E0B);
  static const Color secondaryLight = Color(0xFFFFF8E1);
  static const Color secondaryDark = Color(0xFFD97706);

  // ── Background — Warm, clean whites ──
  static const Color scaffoldBg = Color(0xFFFAF8F6);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color surfaceBg = Color(0xFFF5F0EC);

  // ── Text — Warm neutrals for hierarchy ──
  static const Color textPrimary = Color(0xFF1F1A17);
  static const Color textSecondary = Color(0xFF6B5E54);
  static const Color textHint = Color(0xFFA09688);
  static const Color textOnPrimary = Colors.white;

  // ── Status ──
  static const Color success = Color(0xFF2E9E5A);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF1976D2);

  // ── Borders & Dividers ──
  static const Color border = Color(0xFFE5DDD6);
  static const Color divider = Color(0xFFF0EAE4);

  // ── Shadows ──
  static const Color shadow = Color(0x0D3A1A0A);
  static const Color shadowMedium = Color(0x1A3A1A0A);

  // ── Ratings ──
  static const Color ratingStar = Color(0xFFF59E0B);

  // ── Order status ──
  static const Color statusPending = Color(0xFFF59E0B);
  static const Color statusConfirmed = Color(0xFF1976D2);
  static const Color statusDispatched = Color(0xFF7B68A6);
  static const Color statusDelivered = Color(0xFF2E9E5A);
  static const Color statusCancelled = Color(0xFFD32F2F);
}
