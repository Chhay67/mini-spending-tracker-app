import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/page/add_expense_page.dart';
import 'package:mini_spend_tracker_app/page/category_summary_page.dart';
import 'package:mini_spend_tracker_app/page/dashboard_page.dart';
import 'package:mini_spend_tracker_app/page/main_scaffold_page.dart';
import 'package:mini_spend_tracker_app/page/settings_page.dart';
import 'package:mini_spend_tracker_app/page/transactions_page.dart';
import 'package:mini_spend_tracker_app/route/routes.dart';

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
      return null;
    },
    routes: [
      ShellRoute(
        navigatorKey: shellNavKey,
        builder: (context, state, child) {
          return MainScaffoldPage(child: child);
        },
        routes: [
          GoRoute(
            path: Routes.addExpense.path,
            name: Routes.addExpense.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const AddExpensePage(),
            ),
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

  );
}
