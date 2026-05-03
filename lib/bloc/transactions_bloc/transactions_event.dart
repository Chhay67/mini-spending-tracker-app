part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsEvent {}

final class LoadTransactionsEvent extends TransactionsEvent {
  final DateTime? month;
  final String? search;
  final String? categoryId;
  LoadTransactionsEvent({this.month, this.search, this.categoryId});
}

final class LoadMoreTransactionsEvent extends TransactionsEvent {
  final DateTime? month;
  final String? search;
  final String? categoryId;

  LoadMoreTransactionsEvent({this.month, this.search, this.categoryId});
}

final class DeleteTransactionEvent extends TransactionsEvent {
  final String transactionId;
  DeleteTransactionEvent({required this.transactionId});
}
