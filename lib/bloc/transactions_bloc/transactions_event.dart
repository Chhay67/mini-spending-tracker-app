part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class LoadTransactionsEvent extends TransactionsEvent {
  final DateTime date;
  final String? search;
  final String? categoryId;
  final FilterTypeEnum filterType;
  LoadTransactionsEvent({required this.date, this.search, this.categoryId, this.filterType = FilterTypeEnum.month});
}

final class LoadMoreTransactionsEvent extends TransactionsEvent {
  final DateTime date;
  final String? search;
  final String? categoryId;
  final FilterTypeEnum filterType;

  LoadMoreTransactionsEvent({required this.date, this.search, this.categoryId, this.filterType = FilterTypeEnum.month});
}

final class DeleteTransactionEvent extends TransactionsEvent {
  final String transactionId;
  DeleteTransactionEvent({required this.transactionId});
}
