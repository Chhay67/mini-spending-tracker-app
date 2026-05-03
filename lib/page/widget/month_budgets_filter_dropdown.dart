import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/all_monthly_budgets_cubit/all_monthly_budgets_cubit.dart';
import '../../core/utils/logger.dart';
import '../../core/widget/custom_dropdown_button2.dart';
import '../../model/monthly_budget_model.dart';

class MonthBudgetsFilterDropdown2 extends StatelessWidget {
  const MonthBudgetsFilterDropdown2({super.key, this.onChanged, this.initMonth});
  final void Function(DateTime selectedMonth)? onChanged;
  final DateTime? initMonth;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllMonthlyBudgetsCubit, AllMonthlyBudgetsState>(
      builder: (context, state) {
        final allMonthlyBudgets = state is AllMonthlyBudgetsLoaded ? state.monthlyBudgets : <MonthlyBudgetModel>[];
        final isLoading = state is AllMonthlyBudgetsLoading;
        final initialMonth = allMonthlyBudgets.firstWhereOrNull((monthBudget) {
          if(initMonth == null) return false;
          return monthBudget.year == initMonth!.year && monthBudget.month == initMonth!.month;
        });
        return CustomDropdownButton2<MonthlyBudgetModel>(
          initValue: initialMonth,
          isLoading: isLoading,
          onRefresh: () async => context.read<AllMonthlyBudgetsCubit>().loadAllMonthlyBudgets(),
          labelBuilder: (item) => item?.monthLabel ?? "Select month",
          isError: state is AllMonthlyBudgetsError,
          errorMessage: state is AllMonthlyBudgetsError ? state.message : null,
          items: allMonthlyBudgets,
          onChanged: (selectedMonth) {
            Logger.info("Selected month: $selectedMonth");
            final year = int.parse(selectedMonth.year.toString());
            final month = int.parse(selectedMonth.month.toString());
            onChanged?.call(DateTime(year, month));
          },
        );
      },
    );
  }
}
