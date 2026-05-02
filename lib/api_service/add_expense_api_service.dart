

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/model/add_expense_model.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';

abstract class AddExpenseApiService {

  Future<void> addExpensePostMethod({required AddExpenseModel addExpense});

}

class AddExpenseApiServiceImpl extends AddExpenseApiService {

  AddExpenseApiServiceImpl({required this.dioClient});

  final DioClient dioClient;



  @override
  Future<void> addExpensePostMethod({required AddExpenseModel addExpense}) async{
    try {
      final response = await dioClient.post(
        "",
        queryParameters: {
          "action": "addTransaction",
          "data": jsonEncode({
            "date": DateFormat('yyyy-MM-dd').format(addExpense.date),
            "category_id": addExpense.categoryId,
            "amount": addExpense.amount,
            "note": addExpense.note,
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