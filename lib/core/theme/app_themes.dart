import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/utils/app_padding.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppThemes {
  AppThemes._();

  static ThemeData get lightMode => ThemeData(
    useMaterial3: true,

    // ── Color scheme ───────────────────────────────────────────────────────
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      // Primary – drives ElevatedButton fill, FAB, etc.
      primary: AppColors.primaryDark,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.primaryDark,
      // Secondary – outlined buttons, chips
      secondary: AppColors.primary,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.primaryLight,
      onSecondaryContainer: AppColors.primaryDark,
      // Tertiary / error
      tertiary: AppColors.primary,
      onTertiary: Colors.white,
      error: AppColors.error,
      onError: Colors.white,
      // Surface / background
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceContainerHighest: AppColors.surfaceDim,
      outline: AppColors.primaryLight,
    ),

    scaffoldBackgroundColor: AppColors.background,

    // ── AppBar ─────────────────────────────────────────────────────────────
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.primaryDark,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: AppColors.primary,
        fontFamily: AppFonts.workSans,
        fontSize: 20,
        fontWeight: AppFonts.semiBold,
      ),
      iconTheme: IconThemeData(color: AppColors.primaryDark, size: 24),
      actionsIconTheme: IconThemeData(color: AppColors.primaryDark, size: 24),
    ),

    // ── Cards ──────────────────────────────────────────────────────────────
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
    ),

    // ── Elevated button – "Add Expense" style (dark green, full-width) ─────
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark,
        foregroundColor: Colors.white,
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 15,
          fontWeight: AppFonts.semiBold,
        ),
        elevation: 0,
      ),
    ),

    // ── Outlined button – "Transactions / Categories" style ────────────────
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primaryDark,
        side: const BorderSide(color: AppColors.primaryLight),
        minimumSize: const Size(0, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontFamily: AppFonts.inter,
          fontSize: 14,
          fontWeight: AppFonts.semiBold,
        ),
        elevation: 0,
      ),
    ),

    // ── Text input ─────────────────────────────────────────────────────────
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.primaryLight,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryLight),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryLight),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.primaryDark, width: 1.5),
      ),
      labelStyle: const TextStyle(
        fontFamily: AppFonts.inter,
        color: AppColors.textSecondary,
        fontSize: 13,
        fontWeight: AppFonts.regular,
      ),
    ),

    // ── Progress indicator (budget bar) ────────────────────────────────────
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryDark,
      linearTrackColor: AppColors.primaryLight,
    ),
    // ListTile
    listTileTheme: ListTileThemeData(
      tileColor: AppColors.surface,
      contentPadding:  EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
      dense: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      titleTextStyle: TextStyle(
        fontFamily: AppFonts.workSans,
        fontSize: 16,
        fontWeight: AppFonts.semiBold,
        color: AppColors.textPrimary,
      ),
      subtitleTextStyle: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 14,
        fontWeight: AppFonts.regular,
        color: AppColors.textSecondary,
      ),
      leadingAndTrailingTextStyle: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 14,
        fontWeight: AppFonts.regular,
        color: AppColors.textPrimary,
      )
    ),
    // ── Bottom navigation bar ──────────────────────────────────────────────
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.surface,
      selectedItemColor: AppColors.primaryDark,
      unselectedItemColor: AppColors.navUnselected,
      selectedLabelStyle: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 11,
        fontWeight: AppFonts.semiBold,
      ),
      unselectedLabelStyle: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 11,
        fontWeight: AppFonts.regular,
      ),
      elevation: 8,
      type: BottomNavigationBarType.fixed,
    ),

    // ── Typography ─────────────────────────────────────────────────────────
    textTheme: const TextTheme(
      // Large dollar amounts — Inter Bold
      displayLarge: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 32,
        fontWeight: AppFonts.bold,
        color: AppColors.primaryDark,
      ),
      // Section headings e.g. "Daily Insight" — WorkSans SemiBold
      titleLarge: TextStyle(
        fontFamily: AppFonts.workSans,
        fontSize: 18,
        fontWeight: AppFonts.semiBold,
        color: AppColors.textPrimary,
      ),
      // Card title — WorkSans SemiBold
      titleMedium: TextStyle(
        fontFamily: AppFonts.workSans,
        fontSize: 16,
        fontWeight: AppFonts.semiBold,
        color: AppColors.textPrimary,
      ),
      // Card sub-labels e.g. "REMAINING BALANCE" — Inter SemiBold
      labelSmall: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 11,
        fontWeight: AppFonts.semiBold,
        color: AppColors.textSecondary,
        letterSpacing: 0.8,
      ),
      // Button / chip label — Inter SemiBold
      labelMedium: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 13,
        fontWeight: AppFonts.semiBold,
        color: AppColors.textPrimary,
      ),
      // Body text — Inter Regular
      bodyMedium: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 14,
        fontWeight: AppFonts.regular,
        color: AppColors.textPrimary,
      ),
      bodySmall: TextStyle(
        fontFamily: AppFonts.inter,
        fontSize: 13,
        fontWeight: AppFonts.regular,
        color: AppColors.textSecondary,
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppColors.primaryLight,
      thickness: 1,
    ),

    iconTheme: const IconThemeData(color: AppColors.primaryDark, size: 22),
  );
}
