
import '../api_service/add_expense_api_service.dart';
import '../model/add_expense_model.dart';

abstract class AddExpenseRepository {
  Future<void> addExpense({required AddExpenseModel expense});
  Future<void> updateExpense({required AddExpenseModel expense});

}

class AddExpenseRepositoryImpl extends AddExpenseRepository {
  AddExpenseRepositoryImpl({required this.addExpenseApiService});

  final AddExpenseApiService addExpenseApiService;

  @override
  Future<void> addExpense({required AddExpenseModel expense}) async {
    return await addExpenseApiService.addExpense(expense: expense);
  }

  @override
  Future<void> updateExpense({required AddExpenseModel expense}) async{
    return await addExpenseApiService.updateExpense(expense: expense);
  }
}
