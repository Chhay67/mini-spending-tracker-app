

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/model/add_expense_model.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';

abstract class AddExpenseApiService {

  Future<void> addExpense({required AddExpenseModel expense});
  Future<void> updateExpense({required AddExpenseModel expense});
}

class AddExpenseApiServiceImpl extends AddExpenseApiService {

  AddExpenseApiServiceImpl({required this.dioClient});

  final DioClient dioClient;



  @override
  Future<void> addExpense({required AddExpenseModel expense}) async{
    try {
      final response = await dioClient.post(
        "",
        queryParameters: {
          "action": "addTransaction",
          "data": jsonEncode({
            "date": DateFormat('yyyy-MM-dd').format(expense.date),
            "category_id": expense.categoryId,
            "amount": expense.amount,
            "note": expense.note,
          }),
        },
      );
      return parseOrThrow<void>(response: response, onSuccess: () => true);

    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> updateExpense({required AddExpenseModel expense}) async{
    try {
      final response = await dioClient.post(
        "",
        queryParameters: {
          "action": "updateTransaction",
          "data": jsonEncode({
            "transaction_id": expense.transactionId,
            "date": DateFormat('yyyy-MM-dd').format(expense.date),
            "category_id": expense.categoryId,
            "amount": expense.amount,
            "note": expense.note,
          }),
        },
      );
      return parseOrThrow<void>(response: response, onSuccess: () => true);

    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }


}