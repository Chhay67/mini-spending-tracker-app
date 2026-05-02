part of 'add_expense_cubit.dart';

@immutable
sealed class  AddExpenseState {
  const AddExpenseState();
}

final class AddExpenseInitial extends AddExpenseState {}

final class AddExpenseLoading extends AddExpenseState {}

final class AddExpenseSuccess extends AddExpenseState {}

final class AddExpenseError extends AddExpenseState {
  final String message;

  const AddExpenseError({required this.message});
}

