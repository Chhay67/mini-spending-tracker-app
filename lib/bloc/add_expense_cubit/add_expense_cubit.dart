import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/core/state/action_state.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';
import 'package:mini_spend_tracker_app/model/add_expense_model.dart';

import '../../repository/add_expense_repository.dart';
import 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseRepository repository;

  AddExpenseCubit({required this.repository}) : super(AddExpenseState());

  Future<void> addExpense() async {
    emit(state.copyWith(saveState: ActionLoading()));
    try {
      await repository.addExpense(addExpense: state.addExpense!);
      emit(state.copyWith(saveState: ActionSuccess()));
    } catch (error) {
      emit(state.copyWith(saveState: ActionError(message: error.toString())));
    }
  }

  void updateAddExpense({num? amount, String? category, String? note, DateTime? date}) {
    final updatedAddExpense =
        state.addExpense?.copyWith(amount: amount, category: category, note: note, date: date) ??
        AddExpenseModel(amount: amount ?? 0, category: category ?? '', note: note, date: date ?? DateTime.now());
    Logger.info("Updated AddExpense: ${updatedAddExpense.toAddExpenseJson()}");
    emit(state.copyWith(addExpense: updatedAddExpense));
  }
}
