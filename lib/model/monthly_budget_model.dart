import 'package:equatable/equatable.dart';

class MonthlyBudgetModel extends Equatable {
  const MonthlyBudgetModel({
    required this.success,
    required this.month,
    required this.monthlyBudget,
    required this.monthLabel,
    required this.updatedAt,
  });

  final bool success;
  final String month;
  final num monthlyBudget;
  final String monthLabel;
  final String updatedAt;

  factory MonthlyBudgetModel.fromJson(Map<String, dynamic> json) {
    return MonthlyBudgetModel(
      success: json["success"] ?? false,
      month: json["month"] ?? "",
      monthlyBudget: json["monthlyBudget"] ?? 0,
      monthLabel: json["monthLabel"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
    );
  }

  MonthlyBudgetModel copyWith({String? month, num? monthlyBudget}) {
    return MonthlyBudgetModel(
      success: success,
      month: month ?? this.month,
      monthlyBudget: monthlyBudget ?? this.monthlyBudget,
      monthLabel: monthLabel,
      updatedAt: updatedAt ,
    );
  }

  Map<String, dynamic> toSaveMonthlyBudgetJson() => {
    "action": "saveBudget",
    "month": month,
    "monthlyBudget": monthlyBudget,
  };

  @override
  List<Object?> get props => [success, month, monthlyBudget, monthLabel, updatedAt];
}
