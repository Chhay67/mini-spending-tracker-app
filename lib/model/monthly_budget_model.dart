import 'package:equatable/equatable.dart';

class MonthlyBudgetModel extends Equatable {
  const MonthlyBudgetModel({
    required this.budgetId,
    required this.monthKey,
    required this.year,
    required this.month,
    required this.budgetAmount,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
  });
  final String budgetId;
  final DateTime? monthKey;
  final num year;
  final num month;
  final num budgetAmount;
  final String currency;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory MonthlyBudgetModel.fromJson(Map<String, dynamic> json) {
    return MonthlyBudgetModel(
      budgetId: json["budget_id"] ?? "",
      monthKey: DateTime.tryParse(json["month_key"] ?? ""),
      year: json["year"] ?? 0,
      month: json["month"] ?? 0,
      budgetAmount: json["budget_amount"] ?? 0,
      currency: json["currency"] ?? "",
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }
  factory MonthlyBudgetModel.empty() {
    return MonthlyBudgetModel(
      budgetId: "",
      monthKey: null,
      year: 0,
      month: 0,
      budgetAmount: 0,
      currency: "",
      createdAt: null,
      updatedAt: null,
    );
  }


  MonthlyBudgetModel copyWith({
    String? budgetId,
    DateTime? monthKey,
    num? year,
    num? month,
    num? budgetAmount,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MonthlyBudgetModel(
      budgetId: budgetId ?? this.budgetId,
      monthKey: monthKey ?? this.monthKey,
      year: year ?? this.year,
      month: month ?? this.month,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }


  @override
  List<Object?> get props => [
    budgetId,
    monthKey,
    year,
    month,
    budgetAmount,
    currency,
    createdAt,
    updatedAt,
  ];
}
