class DashboardModel {
  DashboardModel({
    required this.monthKey,
    required this.currency,
    required this.remainingBalance,
    required this.remainingBalanceColor,
    required this.budgetUsagePercent,
    required this.budgetUsageColor,
    required this.monthlyBudget,
    required this.totalSpent,
    required this.budgetPerDay,
    required this.actualPerDay,
    required this.status,
    required this.statusLabel,
    required this.statusColor,
  });

  final String monthKey;
  final String currency;
  final num remainingBalance;
  final String remainingBalanceColor;
  final num budgetUsagePercent;
  final String budgetUsageColor;
  final num monthlyBudget;
  final num totalSpent;
  final num budgetPerDay;
  final num actualPerDay;
  final String status;
  final String statusLabel;
  final String statusColor;

  factory DashboardModel.fromJson(Map<String, dynamic> json){
    return DashboardModel(
      monthKey: json["month_key"] ?? "",
      currency: json["currency"] ?? "",
      remainingBalance: json["remaining_balance"] ?? 0,
      remainingBalanceColor: json["remaining_balance_color"] ?? "",
      budgetUsagePercent: json["budget_usage_percent"] ?? 0,
      budgetUsageColor: json["budget_usage_color"] ?? "",
      monthlyBudget: json["monthly_budget"] ?? 0,
      totalSpent: json["total_spent"] ?? 0,
      budgetPerDay: json["budget_per_day"] ?? 0,
      actualPerDay: json["actual_per_day"] ?? 0,
      status: json["status"] ?? "",
      statusLabel: json["status_label"] ?? "",
      statusColor: json["status_color"] ?? "",
    );
  }

}
