import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/utils/app_padding.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/widget/custom_text_form_field.dart';
import '../../core/widget/default_card.dart';

class MonthlyBudgetShimmer extends StatelessWidget {
  const MonthlyBudgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {

    return DefaultCard(
      children: [
        CustomTextFormField(
          label: "Monthly Budget for",
          labelMainAxisAlignment: MainAxisAlignment.start,
          labelTrailing: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              margin: EdgeInsets.only(left: AppPadding.smallPadding),
              width: 80,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          enabled: false,

          prefixIcon: const Icon(Icons.attach_money),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8),
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
      ],
    );
  }
}
