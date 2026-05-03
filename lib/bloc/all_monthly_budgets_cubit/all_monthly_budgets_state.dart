part of 'all_monthly_budgets_cubit.dart';

@immutable
sealed class AllMonthlyBudgetsState {}

final class AllMonthlyBudgetsInitial extends AllMonthlyBudgetsState {}

final class AllMonthlyBudgetsLoading extends AllMonthlyBudgetsState {}

final class AllMonthlyBudgetsLoaded extends AllMonthlyBudgetsState {
  final List<MonthlyBudgetModel> monthlyBudgets;

  AllMonthlyBudgetsLoaded({required this.monthlyBudgets});
}

final class AllMonthlyBudgetsError extends AllMonthlyBudgetsState {
  final String message;

  AllMonthlyBudgetsError({required this.message});
}
