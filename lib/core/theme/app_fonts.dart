import 'package:flutter/widgets.dart';

/// Central reference for all font families and weights used in the app.
///
/// Font families must match the `family` keys declared in `pubspec.yaml`.
abstract final class AppFonts {
  // ── Family names ────────────────────────────────────────────────────────────

  /// Inter — used for body text and general UI copy.
  static const String inter = 'Inter';

  /// Work Sans — used for headings and display text.
  static const String workSans = 'WorkSans';

  // ── Weights ─────────────────────────────────────────────────────────────────

  /// Regular  (Inter 400)
  static const FontWeight regular = FontWeight.w400;

  /// Semi-bold (WorkSans 600)
  static const FontWeight semiBold = FontWeight.w600;

  /// Bold      (Inter 700)
  static const FontWeight bold = FontWeight.w700;
}
