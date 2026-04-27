import 'package:flutter/material.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../theme/app_colors.dart';

class DatePicker {
  static Future<DateTime?> showDatePickerDialog(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime defaultInitialDate = initialDate ?? now;
    final DateTime defaultFirstDate = firstDate ?? DateTime(now.year - 100);
    final DateTime defaultLastDate = lastDate ?? DateTime(now.year + 100);

    return await showDatePicker(
      context: context,
      initialDate: defaultInitialDate,
      firstDate: defaultFirstDate,
      lastDate: defaultLastDate,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryDark, // Header background color
              onPrimary: Colors.white, // Header text color
              onSurface: AppColors.textPrimary, // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryDark, // Action button color
              ),
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  /// Shows a month picker dialog and returns the selected [DateTime] (year+month
  /// only), or `null` if the user dismisses it.
  ///
  /// Defaults:
  /// - [initialDate] → current month
  /// - [firstDate]   → 100 years ago
  /// - [lastDate]    → current month (cannot pick a future month)
  static Future<DateTime?> showMonthPickerDialog(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime now = DateTime.now();

    return await showMonthPicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(now.year - 100),
      lastDate: lastDate ?? now,
      monthPickerDialogSettings: MonthPickerDialogSettings(
        headerSettings: const PickerHeaderSettings(
          headerBackgroundColor: AppColors.surface,
          headerIconsColor: AppColors.textPrimary,
          headerSelectedIntervalTextStyle: TextStyle(
            color: AppColors.primaryDark,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          headerCurrentPageTextStyle: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        dialogSettings: PickerDialogSettings(
          dialogRoundedCornersRadius: 16,
          dialogBackgroundColor: AppColors.surface,
        ),
        dateButtonsSettings: PickerDateButtonsSettings(
          selectedMonthBackgroundColor: AppColors.primaryDark,
          selectedMonthTextColor: Colors.white,
          unselectedMonthsTextColor: AppColors.textPrimary,
          currentMonthTextColor: AppColors.primary,
        ),
      ),
    );
  }
}
