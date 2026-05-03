import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/repository/transactions_repository.dart';

part 'delete_transaction_state.dart';

class DeleteTransactionCubit extends Cubit<DeleteTransactionState> {
  final TransactionsRepository repository;
  DeleteTransactionCubit({required this.repository}) : super(DeleteTransactionInitial());

  Future<void> deleteTransaction({required String transactionId}) async {
    try {
      emit(DeleteTransactionLoading());
      await repository.deleteTransaction(transactionId: transactionId);
      emit(DeleteTransactionSuccess());
    } catch (error) {
      emit(DeleteTransactionError(message: error.toString()));
    }
  }


}
