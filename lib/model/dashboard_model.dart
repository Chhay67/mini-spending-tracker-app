class DashboardModel {
  DashboardModel({
    required this.success,
    required this.month,
    required this.monthLabel,
    required this.currency,
    required this.symbol,
    required this.monthlyBudget,
    required this.totalSpent,
    required this.remainingBudget,
    required this.usagePercent,
    required this.daysInMonth,
    required this.currentDay,
    required this.budgetPerDay,
    required this.actualPerDay,
    required this.status,
    required this.categorySummary,
    required this.recentTransactions,
  });

  final bool success;
  final String month;
  final String monthLabel;
  final String currency;
  final String symbol;
  final num monthlyBudget;
  final num totalSpent;
  final num remainingBudget;
  final num usagePercent;
  final num daysInMonth;
  final num currentDay;
  final num budgetPerDay;
  final num actualPerDay;
  final String status;
  final List<CategorySummaryModel> categorySummary;
  final List<RecentTransactionModel> recentTransactions;

  factory DashboardModel.fromJson(Map<String, dynamic> json){
    return DashboardModel(
      success: json["success"] ?? false,
      month: json["month"] ?? "",
      monthLabel: json["monthLabel"] ?? "",
      currency: json["currency"] ?? "",
      symbol: json["symbol"] ?? "",
      monthlyBudget: json["monthlyBudget"] ?? 0,
      totalSpent: json["totalSpent"] ?? 0,
      remainingBudget: json["remainingBudget"] ?? 0,
      usagePercent: json["usagePercent"] ?? 0,
      daysInMonth: json["daysInMonth"] ?? 0,
      currentDay: json["currentDay"] ?? 0,
      budgetPerDay: json["budgetPerDay"] ?? 0,
      actualPerDay: json["actualPerDay"] ?? 0,
      status: json["status"] ?? "",
      categorySummary: json["categorySummary"] == null ? [] : List<CategorySummaryModel>.from(json["categorySummary"]!.map((x) => CategorySummaryModel.fromJson(x))),
      recentTransactions: json["recentTransactions"] == null ? [] : List<RecentTransactionModel>.from(json["recentTransactions"]!.map((x) => RecentTransactionModel.fromJson(x))),
    );
  }

}

class CategorySummaryModel {
  CategorySummaryModel({
    required this.categoryId,
    required this.category,
    required this.color,
    required this.total,
    required this.percent,
  });

  final String categoryId;
  final String category;
  final String color;
  final num total;
  final num percent;

  factory CategorySummaryModel.fromJson(Map<String, dynamic> json){
    return CategorySummaryModel(
      categoryId: json["categoryId"] ?? "",
      category: json["category"] ?? "",
      color: json["color"] ?? "",
      total: json["total"] ?? 0,
      percent: json["percent"] ?? 0,
    );
  }

}

class RecentTransactionModel {
  RecentTransactionModel({
    required this.recordId,
    required this.date,
    required this.month,
    required this.category,
    required this.amount,
    required this.note,
    required this.createdAt,
    required this.updatedAt,
  });

  final String recordId;
  final DateTime? date;
  final String month;
  final String category;
  final num amount;
  final String note;
  final String createdAt;
  final String updatedAt;

  factory RecentTransactionModel.fromJson(Map<String, dynamic> json){
    return RecentTransactionModel(
      recordId: json["recordId"] ?? "",
      date: DateTime.tryParse(json["date"] ?? ""),
      month: json["month"] ?? "",
      category: json["category"] ?? "",
      amount: json["amount"] ?? 0,
      note: json["note"] ?? "",
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }

}
