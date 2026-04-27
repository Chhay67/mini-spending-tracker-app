import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_validator.dart';

class AmountTextFormField extends StatelessWidget {
  const AmountTextFormField({super.key, required this.amountController});

  final TextEditingController amountController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return TextFormField(
      controller: amountController,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
      // Only digits and a single decimal point are accepted
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      style: textTheme.displayLarge,
      validator: AppValidator.amount,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        filled: true,
        hintText: "0.00",
        hintStyle: textTheme.displayLarge?.copyWith(
          color: Colors.grey[500],
        ),
        fillColor: AppColors.surface,
        focusColor: AppColors.surface,
        hoverColor: AppColors.surface,
        prefixIcon: Icon(
          Icons.attach_money,
          color: AppColors.primary,
          size: 42,
        ),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: AppColors.error, width: 1),
        ),
      ),
    );
  }
}
