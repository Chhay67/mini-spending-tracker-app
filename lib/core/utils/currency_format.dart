import 'package:intl/intl.dart';

/// Utility class for formatting monetary values using [NumberFormat] from the
/// `intl` package.
///
/// Usage:
/// ```dart
/// CurrencyFormat.format(1234.5);          // "$1,234.50"
/// CurrencyFormat.format(1234.5, symbol: '€'); // "€1,234.50"
/// CurrencyFormat.compact(1234567);        // "$1.2M"
/// CurrencyFormat.parse('\$1,234.50');     // 1234.5
/// ```
class CurrencyFormat {
  CurrencyFormat._();

  // ── Default locale / symbol ──────────────────────────────────────────────

  static const String _defaultLocale = 'en_US';
  static const String _defaultSymbol = '\$';

  // ── Formatters ────────────────────────────────────────────────────────────

  /// Returns a full currency string with the given [symbol] and [decimalDigits].
  ///
  /// Example: `CurrencyFormat.format(1234.5)` → `"$1,234.50"`
  static String format(
    num amount, {
    String symbol = _defaultSymbol,
    String locale = _defaultLocale,
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Returns a compact currency string (abbreviated for large numbers).
  ///
  /// Example: `CurrencyFormat.compact(1234567)` → `"$1.2M"`
  static String compact(
    num amount, {
    String symbol = _defaultSymbol,
    String locale = _defaultLocale,
  }) {
    final formatter = NumberFormat.compactCurrency(
      locale: locale,
      symbol: symbol,
    );
    return formatter.format(amount);
  }

  /// Formats [amount] without a currency symbol (plain number with separators).
  ///
  /// Example: `CurrencyFormat.number(1234567.89)` → `"1,234,567.89"`
  static String number(
    num amount, {
    String locale = _defaultLocale,
    int decimalDigits = 2,
  }) {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits,
    );
    return formatter.format(amount);
  }

  /// Parses a formatted currency string back to a [double].
  ///
  /// Strips any non-numeric characters except `.` before parsing.
  /// Returns `null` if parsing fails.
  ///
  /// Example: `CurrencyFormat.tryParse('\$1,234.50')` → `1234.5`
  static double? tryParse(String value) {
    final cleaned = value.replaceAll(RegExp(r'[^0-9.]'), '');
    return double.tryParse(cleaned);
  }
}
