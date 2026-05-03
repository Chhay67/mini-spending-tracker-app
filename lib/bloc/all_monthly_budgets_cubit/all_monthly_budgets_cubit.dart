import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

import '../../model/monthly_budget_model.dart';

part 'all_monthly_budgets_state.dart';

class AllMonthlyBudgetsCubit extends Cubit<AllMonthlyBudgetsState> {
  final SettingsRepository repository;
  AllMonthlyBudgetsCubit({required this.repository}) : super(AllMonthlyBudgetsInitial());

  Future<void> loadAllMonthlyBudgets() async {
    try {
      emit(AllMonthlyBudgetsLoading());
      final result = await repository.getAllMonthlyBudgets();
      emit(AllMonthlyBudgetsLoaded(monthlyBudgets: result));
    } catch (error) {
      emit(AllMonthlyBudgetsError(message: error.toString()));
    }
  }
}
