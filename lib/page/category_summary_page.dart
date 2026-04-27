import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/currency_format.dart';
import '../core/utils/responsive_utils.dart';

class CategorySummaryPage extends StatelessWidget {
  const CategorySummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: AppPadding.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.defaultSpacing,
        children: [
          Text(
            "Category Summary",
            textAlign: TextAlign.start,
            style: textTheme.displayLarge?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            "Total Spending this month",
            textAlign: TextAlign.center,
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            CurrencyFormat.format(2000.00),
            style: textTheme.displayLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.primaryDark,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: ResponsiveUtils.mobileMaxWidth,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  textAlign: TextAlign.start,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppSpacing.defaultSpacing),
                  itemBuilder: (context, index) {
                    return DefaultCard(
                      children: [
                        Row(
                          spacing: AppSpacing.smallSpacing,
                          children: [
                            CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.deepOrange,
                            ),
                            Expanded(
                              child: Text(
                                "Food & Drinks",
                                style: textTheme.titleMedium?.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              CurrencyFormat.format(500.00),
                              style: textTheme.labelMedium?.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        LinearProgressIndicator(
                          value: 0.75,
                          color: AppColors.primaryDark,
                          backgroundColor: AppColors.primaryLight,
                          minHeight: 6,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
