import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/core/extension/extensions.dart';
import 'package:mini_spend_tracker_app/page/category_summary_page.dart';
import 'package:mini_spend_tracker_app/page/dashboard_page.dart';
import 'package:mini_spend_tracker_app/page/main_scaffold_page.dart';
import 'package:mini_spend_tracker_app/page/settings_page.dart';
import 'package:mini_spend_tracker_app/page/transactions_page.dart';
import 'package:mini_spend_tracker_app/route/routes.dart';
import '../page/add_or_update_expense_page.dart';

class AppGoRouter {
  AppGoRouter._();

  static final GlobalKey<NavigatorState> rootNavKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> shellNavKey =
      GlobalKey<NavigatorState>();

  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
    navigatorKey: rootNavKey,
    debugLogDiagnostics: true,
    initialLocation: Routes.addExpense.path,
    redirect: (context, state) {
      final location = state.uri.path;
      final isValid = Routes.validPaths.contains(location);
      return isValid ? null : Routes.addExpense.path;
    },
    routes: [
      ShellRoute(
        navigatorKey: shellNavKey,
        builder: (context, state, child) {
          final location = state.uri.path;
          final initNavBarIndex = MainScaffoldPage.tabs.indexWhereOrNull((tab) => tab.route.path == location);
          return MainScaffoldPage(initNavBarIndex: initNavBarIndex,child: child);
        },
        routes: [
          GoRoute(
            path: Routes.addExpense.path,
            name: Routes.addExpense.name,
            pageBuilder: (context, state) {
              final transactionId = state.uri.queryParameters['transactionId'];
              final amountString = state.uri.queryParameters['amount'];
              final parsedAmount = double.tryParse(amountString ?? '');
              final categoryId = state.uri.queryParameters['categoryId'];
              final dateString = state.uri.queryParameters['date'];
              final date = DateTime.tryParse(dateString ?? '');
              final note = state.uri.queryParameters['note'];

              return NoTransitionPage(
              key: state.pageKey,
              child:  AddOrUpdateExpensePage(
                transactionId: transactionId,
                amount: parsedAmount,
                categoryId: categoryId,
                date: date,
                note: note,
              ),
            );
            },
          ),
          GoRoute(
            path: Routes.dashboard.path,
            name: Routes.dashboard.name,
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: DashboardPage()),
          ),
          GoRoute(
            path: Routes.transactions.path,
            name: Routes.transactions.name,
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: TransactionsPage()),
          ),
          GoRoute(
            path: Routes. categorySummary.path,
            name: Routes.categorySummary.name,
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: CategorySummaryPage()),
          ),
          GoRoute(
            path: Routes.settings.path,
            name: Routes.settings.name,
            pageBuilder: (context, state) =>
                NoTransitionPage(key: state.pageKey, child: SettingsPage()),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(Routes.addExpense.path);
      });
      return const SizedBox.shrink();
    },
  );
}
