part of 'monthly_budget_cubit.dart';

@immutable
sealed class MonthlyBudgetState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MonthlyBudgetInitial extends MonthlyBudgetState {}

final class MonthlyBudgetLoading extends MonthlyBudgetState {}

final class MonthlyBudgetLoaded extends MonthlyBudgetState {
  MonthlyBudgetLoaded({required this.data, this.saveState = const ActionInitial()});

  final MonthlyBudgetModel data;
  final ActionState saveState;

  MonthlyBudgetLoaded copyWith({MonthlyBudgetModel? data, ActionState? saveState}) {
    return MonthlyBudgetLoaded(data: data ?? this.data, saveState: saveState ?? this.saveState);
  }

  @override
  List<Object?> get props => [data, saveState];
}

final class MonthlyBudgetError extends MonthlyBudgetState {
  MonthlyBudgetError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
