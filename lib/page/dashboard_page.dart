import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/core/widget/default_card.dart';

import '../bloc/nav_bar_cubit/nav_bar_cubit.dart';
import '../core/theme/app_colors.dart';
import '../core/utils/app_padding.dart';
import '../core/utils/app_spacing.dart';
import '../core/utils/currency_format.dart';
import '../core/utils/responsive_utils.dart';
import '../route/routes.dart';
import 'main_scaffold_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
      constraints: const BoxConstraints(
        maxWidth: ResponsiveUtils.mobileMaxWidth,
      ),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back_outlined)),
          Expanded(
            child: Text(
              "April 2026",
              textAlign: TextAlign.center,
              style: textTheme.titleLarge,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_forward_outlined),
          ),
        ],
      ),
    );
  }
}

class _SummaryBudgetView extends StatelessWidget {
  const _SummaryBudgetView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultCard(
      children: [
        Text("REMAINING BALANCE", style: textTheme.labelSmall),
        Text(
          CurrencyFormat.format(2000.00),
          style: textTheme.displayLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w900,
            color: AppColors.primaryDark,
          ),
        ),
        Row(
          spacing: AppSpacing.smallSpacing,
          children: [
            Expanded(
              child: Text(
                "Budget Usage",
                style: textTheme.titleMedium?.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              "23%",
              style: textTheme.labelMedium?.copyWith(
                color: AppColors.textSecondary,
                fontSize: 16,
              ),
            ),
          ],
        ),
        LinearProgressIndicator(
          value: 0.75,
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
                  Text(
                    CurrencyFormat.format(2000.00),
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("TOTAL SPENT", style: textTheme.labelMedium),
                  Text(
                    CurrencyFormat.format(2000.00),
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DailyInsightView extends StatelessWidget {
  const _DailyInsightView();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultCard(
      children: [
        Text(
          "Daily Insight",
          style: textTheme.displayLarge?.copyWith(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        Row(
          spacing: AppSpacing.defaultSpacing,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                padding: AppPadding.all,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.background,
                ),
                child: Column(
                  spacing: AppSpacing.smallSpacing,
                  children: [
                    Text("Budget / Day", style: textTheme.labelMedium),
                    Text(
                      CurrencyFormat.format(200.00),
                      style: textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: AppPadding.all,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.background,
                ),
                child: Column(
                  spacing: AppSpacing.smallSpacing,
                  children: [
                    Text("Actual / Day", style: textTheme.labelMedium),
                    Text(
                      CurrencyFormat.format(200.00),
                      style: textTheme.titleLarge,
                    ),
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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: AppColors.background,
          ),

          child: RichText(
            text: TextSpan(
              style: textTheme.titleLarge,
              children: [
                WidgetSpan(
                  child: Icon(Icons.check_circle, color: Colors.green),
                ),
                TextSpan(text: "Status:"),
                TextSpan(
                  text: " Normal spending",
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _QuickActionButtonView extends StatelessWidget {
  const _QuickActionButtonView({
    this.onAddExpense,
    this.onViewTransactions,
    this.onViewSummary,
  });

  final Function()? onAddExpense;
  final Function()? onViewTransactions;
  final Function()? onViewSummary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: ResponsiveUtils.mobileMaxWidth,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppSpacing.defaultSpacing,
        children: [
          Text(
            "Quick Actions",
            style: textTheme.titleMedium?.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.maxFinite, 52),
            ),
            onPressed: onAddExpense,
            child: Text("Add Expense"),
          ),
          Row(
            spacing: AppSpacing.defaultSpacing,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.green[100],
                    foregroundColor: Colors.green[800],
                  ),
                  onPressed: onViewTransactions,
                  child: Text(
                    "Transactions",
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.green[100],
                    foregroundColor: Colors.green[800],
                  ),
                  onPressed: onViewSummary,
                  child: Text(
                    "Summary",
                    style: textTheme.titleMedium?.copyWith(
                      color: AppColors.primaryDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
