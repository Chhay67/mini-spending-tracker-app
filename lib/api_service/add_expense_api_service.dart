

import 'package:dio/dio.dart';
import 'package:mini_spend_tracker_app/model/add_expense_model.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';

abstract class AddExpenseApiService {


  Future<void> addExpenseGetMethod({required AddExpenseModel addExpense});
  Future<void> addExpensePostMethod({required AddExpenseModel addExpense});

}

class AddExpenseApiServiceImpl extends AddExpenseApiService {

  AddExpenseApiServiceImpl({required this.dioClient});

  final DioClient dioClient;


  @override
  Future<void> addExpenseGetMethod({required AddExpenseModel addExpense}) async{
    try {
      await dioClient.get(
        "",
        queryParameters: addExpense.toAddExpenseJson(),
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> addExpensePostMethod({required AddExpenseModel addExpense}) async{
    try {
      await dioClient.post(
        "",
        data: addExpense.toAddExpenseJson(),
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }


}