import 'package:flutter/foundation.dart';

import '../api_service/add_expense_api_service.dart';
import '../model/add_expense_model.dart';

abstract class AddExpenseRepository {
  Future<void> addExpense({required AddExpenseModel addExpense});
}

class AddExpenseRepositoryImpl extends AddExpenseRepository {
  AddExpenseRepositoryImpl({required this.addExpenseApiService});

  final AddExpenseApiService addExpenseApiService;

  @override
  Future<void> addExpense({required AddExpenseModel addExpense}) async {
    if (kIsWeb) {
      return await addExpenseApiService.addExpenseGetMethod(addExpense: addExpense);
    }
    return await addExpenseApiService.addExpensePostMethod(addExpense: addExpense);
  }
}
