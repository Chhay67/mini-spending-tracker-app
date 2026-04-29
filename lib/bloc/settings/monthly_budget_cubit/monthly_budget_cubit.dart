import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/core/state/action_state.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

import '../../../core/utils/logger.dart';
import '../../../model/monthly_budget_model.dart';

part 'monthly_budget_state.dart';

class MonthlyBudgetCubit extends Cubit<MonthlyBudgetState> {
  final SettingsRepository repository;

  MonthlyBudgetCubit({required this.repository}) : super(MonthlyBudgetInitial());

  Future<void> loadMonthlyBudget({required DateTime month}) async {
    try {
      emit(MonthlyBudgetLoading());
      final monthFormat = DateFormat('yyyy-MM').format(month);
      final resultMonthlyBudget = await repository.getMonthlyBudget(month: monthFormat);
      emit(MonthlyBudgetLoaded(data: resultMonthlyBudget));
    } catch (error) {
      emit(MonthlyBudgetError(message: error.toString()));
    }
  }

  void updateMonthlyBudget({required DateTime month, required num newBudget}) {
    Logger.info("Updating monthly budget for month: ${DateFormat('yyyy-MM').format(month)} with new budget: $newBudget");
    final currentState = state;
    if (currentState is MonthlyBudgetLoaded) {
      final currentMonthlyBudget = currentState.data;
      final monthFormat = DateFormat('yyyy-MM').format(month);
      final updatedMonthlyBudget = currentMonthlyBudget.copyWith(month: monthFormat, monthlyBudget: newBudget);

      emit(MonthlyBudgetLoaded(data: updatedMonthlyBudget));
    }
  }

  void saveMonthlyBudget() async {
    final currentState = state;
    if (currentState is MonthlyBudgetLoaded) {
      try {
        emit(currentState.copyWith(saveState: const ActionLoading()));
        await repository.saveMonthlyBudget(monthlyBudget: currentState.data);
        emit(currentState.copyWith(saveState: const ActionSuccess()));
      } catch (error) {
        emit(currentState.copyWith(saveState: ActionError(message: error.toString())));
      }
    }
  }
}
