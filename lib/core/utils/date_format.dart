import 'package:intl/intl.dart';

class DateFormater {
  /// Returns `dd/MM/yyyy` — e.g. `"27/04/2026"`
  static String formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return '$day/$month/$year';
  }

  /// Returns `yyyy MM` — e.g. `"2026 04"`
  static String formatYearMonth(DateTime date) {
    return DateFormat('MMMM yyyy',).format(date);
  }
}
