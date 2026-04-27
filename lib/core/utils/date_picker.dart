import 'package:flutter/material.dart';

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
    );
  }
}
