import 'package:dio/dio.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';
import '../model/transaction_data_model.dart';

abstract class TransactionsApiService {
  Future<TransactionDataModel> getTransactions({String? monthKey, String? search, String? categoryId, num page = 1, num limit = 10});
  Future<void> deleteTransaction({required String transactionId});
}

class TransactionsApiServiceImpl implements TransactionsApiService {
  TransactionsApiServiceImpl({required this.dioClient});
  final DioClient dioClient;

  @override
  Future<TransactionDataModel> getTransactions({String? monthKey, String? search, String? categoryId, num page = 1, num limit = 10}) async {
    final queryParameters = {'action': 'getTransactions', 'page': page, 'limit': limit};
    if (monthKey != null) {
      queryParameters['month_key'] = monthKey;
    }
    if (search != null) {
      queryParameters['search'] = search;
    }
    if (categoryId != null) {
      queryParameters['category_id'] = categoryId;
    }

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
