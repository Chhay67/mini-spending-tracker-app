import 'package:intl/intl.dart';

class DateFormater {
  static String formatDate(DateTime date,{String pattern = 'dd MMM yyyy'}) {
    return DateFormat(pattern).format(date);
  }

  static String formatYearMonth(DateTime date) {
    return DateFormat('MMMM yyyy',).format(date);
  }

  static String apiDateFormat(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

}
