import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/utils/app_spacing.dart';

import '../theme/app_colors.dart';

/// A styled dropdown form field that visually matches [CustomTextFormField].
///
/// Uses [DropdownButtonFormField2] (dropdown_button2 ^3.0.0) so it participates
/// in a [Form] and supports a [validator].
class CustomDropdownButton2<T> extends StatefulWidget {
  const CustomDropdownButton2({
    super.key,
    required this.items,
    this.initValue,
    required this.onChanged,
    required this.labelBuilder,
    this.label,
    this.hintText,
    this.isRequired = false,
    this.validator,
    this.autoValidateMode,
    this.isLoading = false,
    this.isError = false,
    this.errorMessage,
    this.onRefresh,
    this.isReset = false,
  });

  final List<T> items;

  /// The initially selected value.
  final T? initValue;

  final void Function(T item) onChanged;

  /// Builds the display string for each item.
  final String Function(T? item) labelBuilder;

  /// Optional label rendered above the field (matches [CustomTextFormField]).
  final String? label;

  /// Placeholder shown when nothing is selected.
  final String? hintText;

  /// Shows a red asterisk next to [label] when true.
  final bool isRequired;

  /// Optional form validator. Receives the selected value (may be null).
  final String? Function(T?)? validator;

  final AutovalidateMode? autoValidateMode;

  final bool isLoading;

  final bool isError;
  final String? errorMessage;

  final Future<void> Function()? onRefresh;

  final bool isReset;

  @override
  State<CustomDropdownButton2<T>> createState() =>
      _CustomDropdownButton2State<T>();
}

class _CustomDropdownButton2State<T>
    extends State<CustomDropdownButton2<T>> {
  late final ValueNotifier<T?> _valueNotifier;

  @override
  void initState() {
    super.initState();
    _valueNotifier = ValueNotifier<T?>(widget.initValue);
  }

  @override
  void didUpdateWidget(covariant CustomDropdownButton2<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initValue != widget.initValue) {
      _valueNotifier.value = widget.initValue;
    }
    // Clear selection if the current value is no longer in the list.
    if (widget.items.isNotEmpty &&
        _valueNotifier.value != null &&
        !widget.items.contains(_valueNotifier.value)) {
      _valueNotifier.value = null;
    }
      if (widget.isReset && !oldWidget.isReset) {
        _valueNotifier.value = null;
      }
  }

  @override
  void dispose() {
    _valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // ── Borders matching CustomTextFormField ──────────────────────────────────
    final normalBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
    );
    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(color: AppColors.error, width: 1),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.smallSpacing,
      children: [
        // ── Label with optional required asterisk ─────────────────────────────
        if (widget.label != null)
          RichText(
            text: TextSpan(
              text: widget.label,
              style: textTheme.bodyMedium,
              children: [
                if (widget.isRequired)
                  TextSpan(
                    text: ' *',
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.error,
                    ),
                  ),
              ],
            ),
          ),
        // ── Dropdown ──────────────────────────────────────────────────────────
        DropdownButtonFormField2<T>(
          // v3.0.0: use valueListenable instead of value
          valueListenable: _valueNotifier,
          isExpanded: true,
          style: textTheme.titleMedium,
          autovalidateMode:
              widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
          // ── InputDecoration — identical to CustomTextFormField ────────────
          decoration: InputDecoration(
            hintStyle: textTheme.bodySmall,
            border: normalBorder,
            enabledBorder: normalBorder,
            focusedBorder: normalBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            errorText: widget.isError
                ? widget.errorMessage ?? 'An error occurred'
                : null,
            errorStyle: textTheme.bodySmall?.copyWith(
              color: AppColors.error,
            ),
            filled: true,
            fillColor: AppColors.surface,
            focusColor: AppColors.surface,
            hoverColor: AppColors.surface,
          ),

          hint: widget.hintText != null
              ? Text(widget.hintText!, style: textTheme.bodySmall)
              : null,

          // ── Button shell ──────────────────────────────────────────────────
          buttonStyleData: const FormFieldButtonStyleData(
            padding: EdgeInsets.zero,
          ),
          // ── Dropdown menu panel ───────────────────────────────────────────
          dropdownStyleData: DropdownStyleData(
            elevation: 2,
            isOverButton: false,
            maxHeight: 240,

            padding: EdgeInsets.zero,
            useSafeArea: true,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.fromBorderSide(
                BorderSide(color: Colors.grey.shade400, width: 1),
              ),
            ),
          ),
          isDense: true,
          // ── Chevron icon ──────────────────────────────────────────────────
          iconStyleData: IconStyleData(
            icon: widget.isError
                ? IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    tooltip: 'Refresh',
                    onPressed: widget.onRefresh == null
                        ? null
                        : () async => await widget.onRefresh!.call(),
                    icon: const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.error,
                      size: 20,
                    ),
                  )
                : widget.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey.shade500,
                      ),
          ),

          // ── Selected item highlight ───────────────────────────────────────
          menuItemStyleData: MenuItemStyleData(
            useDecorationHorizontalPadding: true,
            selectedMenuItemBuilder: (context, child) =>
                ColoredBox(color: AppColors.primaryLight, child: child),
          ),

          // ── Validator (same flow as CustomTextFormField) ─────────────────
          validator: (v) {
            if (widget.isRequired && v == null) {
              return 'This field is required';
            }
            if (widget.validator != null) {
              return widget.validator!(v);
            }
            return null;
          },

          // ── Items — v3.0.0 uses DropdownItem<T>, not DropdownMenuItem<T> ──
          onChanged: widget.isLoading
              ? null
              : (T? newValue) {
                  if (newValue != null) {
                    _valueNotifier.value = newValue;
                    widget.onChanged(newValue);
                  }
                },
          items: widget.items
              .map(
                (e) => DropdownItem<T>(
                  value: e,
                  child: Text(
                    widget.labelBuilder(e),
                    style: textTheme.titleMedium,
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
