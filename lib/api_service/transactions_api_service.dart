import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/core/enum/filter_type_enum.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';
import '../model/transaction_data_model.dart';

abstract class TransactionsApiService {
  Future<TransactionDataModel> getTransactions({
    required DateTime date,
    FilterTypeEnum filterType = FilterTypeEnum.month,
    String? search,
    String? categoryId,
    num page = 1,
    num limit = 10,
  });
  Future<void> deleteTransaction({required String transactionId});
}

class TransactionsApiServiceImpl implements TransactionsApiService {
  TransactionsApiServiceImpl({required this.dioClient});
  final DioClient dioClient;

  @override
  Future<TransactionDataModel> getTransactions({
    required DateTime date,
    FilterTypeEnum filterType = FilterTypeEnum.month,
    String? search,
    String? categoryId,
    num page = 1,
    num limit = 10,
  }) async {

    final Map<String,dynamic> queryParameters = {
      'action': 'getTransactions',
      'data' :jsonEncode({
        "filter_type": filterType.name,
        if(filterType == FilterTypeEnum.month)
          "month_key":  DateFormat('yyyy-MM').format(date)
        else
          "date" : DateFormat('yyyy-MM-dd').format(date),
        "search": ?search,
        "category_id": ?categoryId,
        "page": page,
        "limit": limit,
      })
    };


    try {
      final response = await dioClient.get("", queryParameters: queryParameters);

      return parseOrThrow<TransactionDataModel>(response: response, onSuccess: () => TransactionDataModel.fromJson(response.data));
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deleteTransaction({required String transactionId}) async {
    final queryParameters = {'action': 'deleteTransaction', 'transaction_id': transactionId};
    try {
      final response = await dioClient.post("", queryParameters: queryParameters);

      return parseOrThrow<void>(response: response, onSuccess: () => true);
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
