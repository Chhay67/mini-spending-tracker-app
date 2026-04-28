import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/app_padding.dart';
import '../../core/utils/app_spacing.dart';
import '../../core/widget/default_card.dart';

class DailyInsightShimmer extends StatelessWidget {
  const DailyInsightShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DefaultCard(
      children: [
        Text(
          "Daily Insight",
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          spacing: AppSpacing.defaultSpacing,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: AppPadding.all,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.background,
                ),
                child: Column(
                  spacing: AppSpacing.smallSpacing,
                  children: [
                    Text("Budget / Day", style: textTheme.labelMedium),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: AppPadding.all,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.background,
                ),
                child: Column(
                  spacing: AppSpacing.smallSpacing,
                  children: [
                    Text("Actual / Day", style: textTheme.labelMedium),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Container(
          width: double.maxFinite,
          padding: AppPadding.all,
          margin: EdgeInsets.only(top: AppPadding.defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.background,
          ),
          child: Row(
            children: [
              Text("Status : ", style: textTheme.titleLarge),
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
