import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_spend_tracker_app/core/utils/app_spacing.dart';

import '../theme/app_colors.dart';
import '../utils/responsive_utils.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.suffixIcon,
    this.hintText,
    this.onTap,
    this.readOnly = false,
    this.minLines,
    this.maxLines,
    this.maxLength,
    this.controller,
    this.initialValue,
    this.inputFormatters,
    this.validator,
    this.enabled,
    this.style,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.textDirection,
    this.autocorrect = true,
    this.autofillHints,
    this.autofocus = false,
    this.autoValidateMode = AutovalidateMode.disabled,
    this.canRequestFocus = true,
    this.focusNode,
    this.expands = false,
    this.obscureText = false,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.showCursor,
    this.textInputAction,
    this.textAlignVertical,
    this.textCapitalization = TextCapitalization.none,
    this.isRequired = false,
      this.prefixIcon,
    this.hintStyle,
    this.labelTrailing,
    this.forceErrorText,
    this.suffix,
    this.labelMainAxisAlignment = MainAxisAlignment.spaceBetween,
    this.spacing = AppSpacing.smallSpacing,
  });

  final String? label;
  final Widget? labelTrailing;
  final String? hintText;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool readOnly;
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? enabled;
  final TextStyle? style;
  final TextStyle? hintStyle;

  final TextAlign textAlign;
  final TextInputType? keyboardType;
  final void Function(String value)? onChanged;
  final void Function(String? value)? onSaved;
  final TextDirection? textDirection;
  final bool autocorrect;
  final Iterable<String>? autofillHints;
  final bool autofocus;
  final AutovalidateMode? autoValidateMode;
  final bool canRequestFocus;
  final FocusNode? focusNode;
  final bool expands;
  final bool obscureText;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final bool? showCursor;
  final TextInputAction? textInputAction;
  final TextAlignVertical? textAlignVertical;
  final TextCapitalization textCapitalization;
  final bool isRequired;
  final String? forceErrorText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final MainAxisAlignment labelMainAxisAlignment ;
  final double spacing;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: ResponsiveUtils.mobileMaxWidth,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: spacing,
        children: [
          if (label != null)
            Row(
              mainAxisAlignment: labelMainAxisAlignment,
              children: [
                Flexible(
                  child: RichText(
                    text: TextSpan(
                      text: label,
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      children: [
                        if (isRequired)
                          TextSpan(
                            text: " *",
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if(labelTrailing != null) ...[

                  labelTrailing!,
                ],
              ],
            ),
          TextFormField(
            onTap: onTap,
            readOnly: readOnly,
            ignorePointers: false,
            minLines: minLines,
            maxLines: maxLines,
            maxLength: maxLength,
            controller: controller,
            initialValue: initialValue,
            inputFormatters: inputFormatters,
            validator: (value) {
              if(isRequired && (value == null || value.isEmpty)) {
                return "This field is required";
              }
              if(validator != null) {
                return validator!(value);
              }
              return null;
            },
            enabled: enabled,
            style: style ?? textTheme.titleMedium,
            textAlign: textAlign,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onSaved: onSaved,
            textDirection: textDirection,
            autocorrect: autocorrect,
            autofillHints: autofillHints,
            autofocus: autofocus,
            autovalidateMode: autoValidateMode,
            canRequestFocus: canRequestFocus,
            focusNode: focusNode,
            expands: expands,
            obscureText: obscureText,
            onEditingComplete: onEditingComplete,
            onFieldSubmitted: onFieldSubmitted,
            showCursor: showCursor,
            textInputAction: textInputAction,
            textAlignVertical: textAlignVertical,
            textCapitalization: textCapitalization,
            forceErrorText: forceErrorText,
            decoration: InputDecoration(
              hintStyle: hintStyle ?? textTheme.bodySmall,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              prefixIcon: prefixIcon,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.error, width: 1),
              ),
              suffix:suffix ,
              filled: true,
              suffixIcon: suffixIcon,
              hintText: hintText,
              fillColor: AppColors.surface,
              focusColor: AppColors.surface,
              hoverColor: AppColors.surface,
            ),
          ),
        ],
      ),
    );
  }
}
