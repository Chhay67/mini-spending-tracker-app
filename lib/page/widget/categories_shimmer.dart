import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/utils/app_spacing.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_utils.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSpacing.defaultSpacing,
      children: [
        // Static Header (Matches _CategoryHeaderButton)
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.textPrimary),
              ),
              OutlinedButton(
                style: Theme
                    .of(context)
                    .outlinedButtonTheme
                    .style
                    ?.copyWith(
                  backgroundColor: WidgetStateProperty.all(AppColors.surface),
                ),
                onPressed: null, // Disabled during loading
                child: const Text("Add"),
              ),
            ],
          ),
        ),
        
        // Shimmering List
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
          child: ListView.builder(
            itemCount: 5, // Show 5 skeleton tiles
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final first = index == 0;
              final last = index == 4;
              final shape = RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.primaryLight, width: 1),
                borderRadius: BorderRadius.vertical(
                  top: first ? const Radius.circular(8) : Radius.zero,
                  bottom: last ? const Radius.circular(8) : Radius.zero,
                ),
              );
              
              return ListTile(
                shape: shape,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100.0 + (index * 15), // Variable width for visual variety
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                trailing: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
