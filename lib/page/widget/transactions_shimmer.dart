import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_padding.dart';
import '../../core/utils/app_spacing.dart';
import '../../core/utils/responsive_utils.dart';

class TransactionsShimmer extends StatelessWidget {
  const TransactionsShimmer({super.key});

  Widget _shimmerBox({required double width, required double height, double radius = 4}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surface = Theme.of(context).colorScheme.surface;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
      child: Column(
        spacing: AppSpacing.defaultSpacing,
        children: [
          // Search field shimmer
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),

          // Filter row shimmer: date button + filter type + category dropdown
          SizedBox(
            height: kDefaultDropDownHeight,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Date TextButton placeholder
                Container(
                  height: kDefaultDropDownHeight,
                  padding: const EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    spacing: AppSpacing.defaultSpacing,
                    children: [
                      _shimmerBox(width: 64, height: 14),
                      const Icon(Icons.calendar_month_outlined, color: AppColors.navUnselected, size: 18),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.smallSpacing),
                // Filter type dropdown placeholder
                _shimmerBox(width: 90, height: kDefaultDropDownHeight, radius: 8),
                const SizedBox(width: AppSpacing.smallSpacing),
                // Category dropdown placeholder
                _shimmerBox(width: 110, height: kDefaultDropDownHeight, radius: 8),
              ],
            ),
          ),

          // Transaction list items
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.defaultSpacing),
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.defaultPadding,
                  vertical: AppPadding.defaultPadding,
                ),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  spacing: AppSpacing.defaultSpacing,
                  children: [
                    // Left: title + date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _shimmerBox(width: 150, height: 18),
                          const SizedBox(height: 8),
                          _shimmerBox(width: 100, height: 14),
                        ],
                      ),
                    ),
                    // Right: amount + edit/delete icons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _shimmerBox(width: 60, height: 18),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            _shimmerBox(width: 18, height: 18, radius: 4),
                            const SizedBox(width: AppSpacing.smallSpacing),
                            _shimmerBox(width: 18, height: 18, radius: 4),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}