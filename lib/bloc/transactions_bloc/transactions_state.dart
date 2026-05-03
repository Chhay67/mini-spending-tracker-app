part of 'transactions_bloc.dart';

@immutable
sealed class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object?> get props => [];
}

final class TransactionsInitial extends TransactionsState {
  const TransactionsInitial();
}

final class TransactionsLoading extends TransactionsState {
  const TransactionsLoading();
}

final class TransactionsLoaded extends TransactionsState {
  final List<TransactionModel> transactions;
  final PaginationModel pagination;

  const TransactionsLoaded({required this.transactions, required this.pagination});

  TransactionsLoaded copyWith({
    List<TransactionModel>? transactions,
    PaginationModel? pagination,
  }) {
    return TransactionsLoaded(
      transactions: transactions ?? this.transactions,
      pagination: pagination ?? this.pagination,
    );
  }

  @override
  List<Object?> get props => [transactions, pagination];
}

final class TransactionsError extends TransactionsState {
  final String message;
  const TransactionsError({required this.message});
}
