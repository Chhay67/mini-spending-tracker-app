/// Central collection of form-field validators for the app.
///
/// Every method matches the `FormFieldValidator<String>` signature so it can
/// be passed directly to a [TextFormField]'s `validator` parameter.
abstract final class AppValidator {
  // ── Money / amount ─────────────────────────────────────────────────────────

  /// Validates that [value] is a well-formed positive monetary amount (double).
  ///
  /// Rules:
  /// - Must not be empty.
  /// - Must be parseable as a [double].
  /// - Must be greater than 0.
  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final trimmed = value.trim();
    final parsed = double.tryParse(trimmed);
    if (parsed == null) {
      return 'Enter a valid amount (e.g. 12.50)';
    }
    if (parsed <= 0) {
      return 'Amount must be greater than 0';
    }

    return null;
  }

  // ── Required text ──────────────────────────────────────────────────────────

  /// Validates that [value] is not null or blank.
  static String? required(String? value, {String message = 'This field is required'}) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }
}
