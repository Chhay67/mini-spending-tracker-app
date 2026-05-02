abstract class SummaryBudgetSelector {
  const SummaryBudgetSelector();
}

class SummaryBudgetInitial extends SummaryBudgetSelector {
  const SummaryBudgetInitial();
}

class SummaryBudgetLoading extends SummaryBudgetSelector {
  const SummaryBudgetLoading();
}

class SummaryBudgetLoaded extends SummaryBudgetSelector {
  const SummaryBudgetLoaded({
    required this.remainingBudget,
    required this.usagePercent,
    required this.monthlyBudget,
    required this.totalSpent,
    required this.budgetUsageColor,
  });

  final num remainingBudget;
  final num usagePercent;
  final num monthlyBudget;
  final num totalSpent;
  final String budgetUsageColor;

}

class SummaryBudgetError extends SummaryBudgetSelector {
  const SummaryBudgetError({required this.message});

  final String message;
}
