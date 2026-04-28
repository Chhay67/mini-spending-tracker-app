import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:mini_spend_tracker_app/core/utils/date_picker.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';

import '../bloc/nav_bar_cubit/nav_bar_cubit.dart';
import '../bloc/selected_month_cubit/selected_month_cubit.dart';
import '../core/enum/status_enum.dart';
import '../core/state/daily_insight_selector.dart';
import '../core/state/summary_budget_selector.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/currency_format.dart';
import '../core/utils/date_format.dart';
import '../core/utils/responsive_utils.dart';
import '../core/widget/error_state_widget.dart';
import '../init_dependencies.dart';
import '../route/routes.dart';
import 'main_scaffold_page.dart';
import 'widget/daily_insight_shimmer.dart';
import 'widget/summary_budget_shimmer.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => serviceLocator<DashboardBloc>()..add(LoadDashboardDataEvent(month: context.read<SelectedMonthCubit>().state)),
      child: BlocListener<SelectedMonthCubit, DateTime>(
        listener: (context, state) => context.read<DashboardBloc>().add(LoadDashboardDataEvent(month: state)),

        child: SingleChildScrollView(
          padding: AppPadding.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: AppSpacing.defaultSpacing,
            children: [
              _MonthSelection(),
              _SummaryBudgetView(),
              _DailyInsightView(),
              _QuickActionButtonView(
                onAddExpense: () => _navigateToRoute(context, Routes.addExpense.path),
                onViewTransactions: () => _navigateToRoute(context, Routes.transactions.path),
                onViewSummary: () => _navigateToRoute(context, Routes.categorySummary.path),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRoute(BuildContext context, String routePath) {
    final tabs = MainScaffoldPage.tabs;
    final index = tabs.indexWhere((tab) => tab.route.path == routePath);
    if (index != -1) {
      context.read<NavBarCubit>().onChanged(index);
      context.goNamed(tabs[index].route.name);
    }
  }
}

class _MonthSelection extends StatelessWidget {
  const _MonthSelection();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
      child: BlocBuilder<SelectedMonthCubit, DateTime>(
        builder: (context, selectedMonth) {
          return Row(
            children: [
              IconButton(
                onPressed: () {
                  context.read<SelectedMonthCubit>().onClickPreviousMonth();
                },
                icon: Icon(Icons.arrow_back_outlined),
              ),
              Expanded(
                child: TextButton(
                  child: Text(DateFormater.formatYearMonth(selectedMonth), textAlign: TextAlign.center, style: textTheme.titleLarge),
                  onPressed: () async {
                    final pickedMonth = await DatePicker.showMonthPickerDialog(context, initialDate: selectedMonth);
                    if (pickedMonth != null && context.mounted) {
                      context.read<SelectedMonthCubit>().onMonthChanged(newMonth: pickedMonth);
                    }
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  context.read<SelectedMonthCubit>().onClickNextMonth();
                },
                icon: Icon(Icons.arrow_forward_outlined),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _SummaryBudgetView extends StatelessWidget {
  const _SummaryBudgetView();

  void onRetry(BuildContext context) {
    context.read<DashboardBloc>().add(LoadDashboardDataEvent(month: context.read<SelectedMonthCubit>().state));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocSelector<DashboardBloc, DashboardState, SummaryBudgetSelector>(
      selector: (state) {
        if (state is DashboardLoading) {
          return const SummaryBudgetLoading();
        }
        if (state is DashboardError) {
          return SummaryBudgetError(message: state.message);
        }

        if (state is DashboardLoaded) {
          return SummaryBudgetLoaded(
            remainingBudget: state.data.remainingBudget,
            usagePercent: state.data.usagePercent,
            monthlyBudget: state.data.monthlyBudget,
            totalSpent: state.data.totalSpent,
          );
        }
        return const SummaryBudgetInitial();
      },
      builder: (context, state) {
        if (state is SummaryBudgetLoading || state is SummaryBudgetInitial) {
          return const SummaryBudgetShimmer();
        }
        if (state is SummaryBudgetError) {
          return ErrorStateWidget(message: state.message, onRetry: () => onRetry(context));
        }
        if (state is SummaryBudgetLoaded) {
          return DefaultCard(
            children: [
              Text("REMAINING BALANCE", style: textTheme.labelSmall),
              Text(
                CurrencyFormat.format(state.remainingBudget),
                style: textTheme.displayLarge?.copyWith(fontSize: 32, fontWeight: FontWeight.w900, color: AppColors.primaryDark),
              ),
              Row(
                spacing: AppSpacing.smallSpacing,
                children: [
                  Expanded(
                    child: Text("Budget Usage", style: textTheme.titleMedium?.copyWith(color: AppColors.textPrimary)),
                  ),
                  Text("${state.usagePercent}%", style: textTheme.labelMedium?.copyWith(color: AppColors.textSecondary, fontSize: 16)),
                ],
              ),
              LinearProgressIndicator(
                value: state.usagePercent / 100,
                color: AppColors.primaryDark,
                backgroundColor: AppColors.primaryLight,
                minHeight: 6,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              const SizedBox(height: AppSpacing.defaultSpacing),
              Divider(color: AppColors.primaryLight, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("MONTHLY BUDGET", style: textTheme.labelMedium),
                        Text(CurrencyFormat.format(state.monthlyBudget), style: textTheme.labelMedium),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("TOTAL SPENT", style: textTheme.labelMedium),
                        Text(CurrencyFormat.format(state.totalSpent), style: textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _DailyInsightView extends StatelessWidget {
  const _DailyInsightView();

  void onRetry(BuildContext context) {
    context.read<DashboardBloc>().add(LoadDashboardDataEvent(month: context.read<SelectedMonthCubit>().state));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocSelector<DashboardBloc, DashboardState, DailyInsightSelector>(
      selector: (state) {
        if (state is DashboardLoading) {
          return const DailyInsightLoading();
        }
        if (state is DashboardError) {
          return DailyInsightError(message: state.message);
        }

        if (state is DashboardLoaded) {
          return DailyInsightLoaded(
            actualPerDay: state.data.actualPerDay,
            budgetPerDay: state.data.budgetPerDay,
            status: state.data.status,
          );
        }
        return const DailyInsightInitial();
      },
      builder: (context, state) {
        if (state is DailyInsightLoading || state is DailyInsightInitial) {
          return const DailyInsightShimmer();
        }
        if (state is DailyInsightError) {
          return ErrorStateWidget(
            message: state.message,
            onRetry: () =>  onRetry(context),
          );
        }
        if (state is DailyInsightLoaded) {
          final statusX = DashboardStatusX.fromString(state.status);
          return DefaultCard(
            children: [
              Text(
                "Daily Insight",
                style: textTheme.displayLarge?.copyWith(color: AppColors.textPrimary, fontSize: 24, fontWeight: FontWeight.w800),
              ),
              Row(
                spacing: AppSpacing.defaultSpacing,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding: AppPadding.all,
                      width: double.maxFinite,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.background),
                      child: Column(
                        spacing: AppSpacing.smallSpacing,
                        children: [
                          Text("Budget / Day", style: textTheme.labelMedium),
                          Text(CurrencyFormat.format(state.budgetPerDay), style: textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: AppPadding.all,
                      width: double.maxFinite,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.background),
                      child: Column(
                        spacing: AppSpacing.smallSpacing,
                        children: [
                          Text("Actual / Day", style: textTheme.labelMedium),
                          Text(CurrencyFormat.format(state.actualPerDay), style: textTheme.titleLarge),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                width: double.maxFinite,
                padding: AppPadding.all,
                margin: EdgeInsets.only(top: AppPadding.defaultPadding),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: AppColors.background),

                child: RichText(
                  text: TextSpan(
                    style: textTheme.titleLarge,
                    children: [
                      TextSpan(text: "Status : "),
                      TextSpan(
                        text: statusX.label,
                        style: textTheme.titleLarge?.copyWith(color: statusX.color, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _QuickActionButtonView extends StatelessWidget {
  const _QuickActionButtonView({this.onAddExpense, this.onViewTransactions, this.onViewSummary});

  final Function()? onAddExpense;
  final Function()? onViewTransactions;
  final Function()? onViewSummary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: ResponsiveUtils.mobileMaxWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.defaultSpacing,
        children: [
          Text("Quick Actions", style: textTheme.titleMedium?.copyWith(color: AppColors.textPrimary)),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: Size(double.maxFinite, 52)),
            onPressed: onAddExpense,
            child: Text("Add Expense"),
          ),
          Row(
            spacing: AppSpacing.defaultSpacing,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.green[100], foregroundColor: Colors.green[800]),
                  onPressed: onViewTransactions,
                  child: Text("Transactions", style: textTheme.titleMedium?.copyWith(color: AppColors.primaryDark)),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0, backgroundColor: Colors.green[100], foregroundColor: Colors.green[800]),
                  onPressed: onViewSummary,
                  child: Text("Summary", style: textTheme.titleMedium?.copyWith(color: AppColors.primaryDark)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
