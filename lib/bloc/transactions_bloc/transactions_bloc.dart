import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/core/enum/filter_type_enum.dart';
import 'package:mini_spend_tracker_app/model/transaction_model.dart';
import 'package:mini_spend_tracker_app/repository/transactions_repository.dart';

import '../../model/pagination_model.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  final TransactionsRepository repository;
  TransactionsBloc({required this.repository}) : super(TransactionsInitial()) {
    on<LoadTransactionsEvent>(_loadTransactions);
    on<LoadMoreTransactionsEvent>(_loadMoreTransactions);
    on<DeleteTransactionEvent>(_deleteTransaction);
  }

  FutureOr<void> _loadTransactions(LoadTransactionsEvent event, Emitter<TransactionsState> emit) async {
    try {
      emit(const TransactionsLoading());
      final result = await repository.getTransactions(
         date:  event.date,
          filterType: event.filterType,
          search: event.search,
          categoryId: event.categoryId,

      );

      emit(TransactionsLoaded(transactions: result.transactions, pagination: result.pagination));
    } catch (error) {
      emit(TransactionsError(message: error.toString()));
    }
  }

  FutureOr<void> _loadMoreTransactions(LoadMoreTransactionsEvent event, Emitter<TransactionsState> emit)async {
    final currentState = state;
    if (currentState is TransactionsLoaded && currentState.pagination.hasNext) {
      try {
        final result = await repository.getTransactions(
            date: event.date,
            search: event.search,
            categoryId: event.categoryId,
            page: currentState.pagination.page + 1,
            filterType: event.filterType,
         );

        final updatedTransactions = [...currentState.transactions, ...result.transactions];
        emit(currentState.copyWith(transactions:updatedTransactions, pagination: result.pagination));

      } catch (error) {
        emit(TransactionsError(message: error.toString()));
      }
    }
  }

  FutureOr<void> _deleteTransaction(DeleteTransactionEvent event, Emitter<TransactionsState> emit)async {
    final currentState = state;
    if (currentState is TransactionsLoaded) {
      final transactionToDelete = currentState.transactions.firstWhereOrNull((transaction) => transaction.transactionId == event.transactionId);
      if (transactionToDelete == null) return;
      final updatedTransactions = currentState.transactions.where((transaction) => transaction.transactionId != transactionToDelete.transactionId).toList();
      emit(currentState.copyWith(transactions: updatedTransactions));

    }

  }
}
