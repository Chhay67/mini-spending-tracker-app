import 'package:intl/intl.dart';

class DateFormater {
  /// Returns `dd/MM/yyyy` — e.g. `"27/04/2026"`
  static String formatDate(DateTime date,{String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  /// Returns `yyyy MM` — e.g. `"2026 04"`
  static String formatYearMonth(DateTime date) {
    return DateFormat('MMMM yyyy',).format(date);
  }



}
