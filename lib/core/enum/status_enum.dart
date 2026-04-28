

import 'package:flutter/material.dart';

enum DashboardStatus {
  noBudget,
  noExpense,
  overspending,
  warning,
  normal,
}

extension DashboardStatusX on DashboardStatus {
  String get label {
    switch (this) {
      case DashboardStatus.noBudget:
        return 'No Budget';
      case DashboardStatus.noExpense:
        return 'No Expense';
      case DashboardStatus.overspending:
        return 'Overspending';
      case DashboardStatus.warning:
        return 'Warning';
      case DashboardStatus.normal:
        return 'Normal Spending';
    }
  }

  Color get color {
    switch (this) {
      case DashboardStatus.noBudget:
        return Colors.grey;
      case DashboardStatus.noExpense:
        return Colors.blue;
      case DashboardStatus.overspending:
        return Colors.red;
      case DashboardStatus.warning:
        return Colors.orange;
      case DashboardStatus.normal:
        return Colors.green;
    }
  }

  static DashboardStatus fromString(String? status) {
    switch (status) {
      case 'No Budget':
        return DashboardStatus.noBudget;
      case 'No Expense':
        return DashboardStatus.noExpense;
      case 'Overspending':
        return DashboardStatus.overspending;
      case 'Warning':
        return DashboardStatus.warning;
      case 'Normal Spending':
        return DashboardStatus.normal;
      default:
        return DashboardStatus.normal;
    }
  }
}