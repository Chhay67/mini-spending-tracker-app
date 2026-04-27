import 'package:flutter/material.dart';

import '../utils/app_padding.dart';
import '../utils/app_spacing.dart';
import '../utils/responsive_utils.dart';

class DefaultCard extends StatelessWidget {
  const DefaultCard({
    super.key,
    this.children = const [],
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: ResponsiveUtils.mobileMaxWidth,
      ),
      child: Card(
        child: Padding(
          padding: AppPadding.all,
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: MainAxisSize.max,
            spacing: AppSpacing.smallSpacing,
            children: children,
          ),
        ),
      ),
    );
  }
}
