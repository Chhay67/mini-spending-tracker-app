import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/constants.dart';
import '../../core/utils/app_spacing.dart';
import '../../core/utils/responsive_utils.dart';
import '../../core/widget/default_card.dart';

class CategoriesSummaryShimmer extends StatelessWidget {
  const CategoriesSummaryShimmer({super.key});



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: AppSpacing.defaultSpacing,
      children: [
        _ShimmerBox(width: 200, height: 30),
        _ShimmerBox(width: 180, height: 32),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.defaultSpacing,
            children: [
              Row(
                spacing: AppSpacing.smallSpacing,
                children: [
                  _ShimmerBox(width: 100, height: kDefaultDropDownHeight),
                  _ShimmerBox(width: 80, height: kDefaultDropDownHeight),
                ],
              ),
              _ShimmerBox(width: 120, height: 24),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.defaultSpacing),
                itemBuilder: (context, index) {
                  return DefaultCard(
                    children: [
                      Row(
                        spacing: AppSpacing.smallSpacing,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: const CircleAvatar(radius: 4, backgroundColor: Colors.white),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _ShimmerBox(width: 120, height: 24),
                            ),
                          ),
                          _ShimmerBox(width: 60, height: 24),
                        ],
                      ),
                      _ShimmerBox(width: double.infinity, height: 6, borderRadius: 8),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  const _ShimmerBox({
    required this.width,
    required this.height,
    this.borderRadius = 4,
});
  final double width;
  final double height;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
