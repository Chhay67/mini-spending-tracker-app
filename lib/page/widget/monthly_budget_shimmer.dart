import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_spacing.dart';
import '../../core/widget/custom_text_form_field.dart';
import '../../core/widget/default_card.dart';

class MonthlyBudgetShimmer extends StatelessWidget {
  const MonthlyBudgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DefaultCard(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.smallSpacing,
          children: [
            Text(
              "Monthly Budget",
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: CustomTextFormField(
                enabled: false,
                hintText: "0.00",
                prefixIcon: const Icon(Icons.attach_money),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const OutlinedButton(
                        onPressed: null,
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
