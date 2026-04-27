import 'package:flutter/material.dart';

import '../core/utils/app_padding.dart';
import '../core/utils/app_spacing.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppPadding.all,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: AppSpacing.defaultSpacing,
        children: [],
      ),
    );
  }
}
