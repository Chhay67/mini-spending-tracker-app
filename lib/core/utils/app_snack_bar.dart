import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppSnackBar {
  static void showSuccess(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: AppColors.success,
        ),
      );
  }

  static void showError(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: AppColors.error,
        ),
      );
  }
}
