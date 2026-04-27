import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary greens (from UI)
  static const Color primaryDark   = Color(0xFF1B5E3B); // dark forest green – CTA buttons, balance, progress
  static const Color primary       = Color(0xFF27AE60); // medium green – title, status, accents
  static const Color primaryLight  = Color(0xFFE8F5E9); // light mint – outlined button bg, chip bg

  // Scaffold / surface
  static const Color background    = Color(0xFFEDF7ED); // very light mint – scaffold bg
  static const Color surface       = Color(0xFFFFFFFF); // white – cards, app bar, bottom nav
  static const Color surfaceDim    = Color(0xFFF4FAF4); // subtle off-white – inner tiles

  // Text
  static const Color textPrimary   = Color(0xFF0D0D0D); // near black
  static const Color textSecondary = Color(0xFF6B7280); // muted grey – labels, sub-text

  // Bottom nav unselected
  static const Color navUnselected = Color(0xFF9CA3AF);

  // Status colors
  static const Color success       = Color(0xFF27AE60);
  static const Color  error         = Color(0xFFE53935);
}