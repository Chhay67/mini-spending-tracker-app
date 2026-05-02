import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/add_expense_model.dart';
import '../../repository/add_expense_repository.dart';

part 'add_expense_state.dart';

class AddExpenseCubit extends Cubit<AddExpenseState> {
  final AddExpenseRepository repository;
  AddExpenseCubit({required this.repository}) : super(AddExpenseInitial());

  Future<void> addExpense({required num amount, DateTime? date, required String categoryId, String? note}) async {
    try {
      emit(AddExpenseLoading());
      final addExpense = AddExpenseModel(amount: amount, date: date ?? DateTime.now(), categoryId: categoryId, note: note);
      await repository.addExpense(addExpense: addExpense);

      emit(AddExpenseSuccess());
    } catch (error) {
      emit(AddExpenseError(message: error.toString()));
    }
  }
}
