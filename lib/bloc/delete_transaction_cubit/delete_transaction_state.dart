part of 'delete_transaction_cubit.dart';

@immutable
sealed class DeleteTransactionState {}

final class DeleteTransactionInitial extends DeleteTransactionState {}

final class DeleteTransactionLoading extends DeleteTransactionState {}

final class DeleteTransactionSuccess extends DeleteTransactionState {}

final class DeleteTransactionError extends DeleteTransactionState {
  final String message;
  DeleteTransactionError({required this.message});
}