import 'package:mini_spend_tracker_app/model/transaction_data_model.dart';

import '../api_service/transactions_api_service.dart';
import '../core/enum/filter_type_enum.dart';

abstract class TransactionsRepository {
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

class TransactionsRepositoryImpl implements TransactionsRepository {
  final TransactionsApiService transactionsApiService;
  TransactionsRepositoryImpl({required this.transactionsApiService});

  @override
  Future<TransactionDataModel> getTransactions({
    required DateTime date,
    FilterTypeEnum filterType = FilterTypeEnum.month,
    String? search,
    String? categoryId,
    num page = 1,
    num limit = 10,
  }) async {
    return await transactionsApiService.getTransactions(
      date: date,
      filterType: filterType,
      search: search,
      categoryId: categoryId,
      page: page,
      limit: limit,
    );
  }

  @override
  Future<void> deleteTransaction({required String transactionId}) async {
    return await transactionsApiService.deleteTransaction(transactionId: transactionId);
  }
}
