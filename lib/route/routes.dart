import 'package:mini_spend_tracker_app/route/utils/route_data.dart';

class Routes {
  static const transactions = RouteData(name: 'transactions', path: '/transactions');
  static const settings = RouteData(name: 'settings', path: '/settings');
  static const addExpense = RouteData(name: 'add_expense', path: '/');
  static const categorySummary = RouteData(name: 'category_summary', path: '/category-summary');
  static const dashboard = RouteData(name: 'dashboard', path: '/dashboard');

  /// All registered route paths. Used by the router redirect guard to
  /// reject navigation to unknown locations.
  static final List<String> validPaths = [
    addExpense.path,
    dashboard.path,
    transactions.path,
    categorySummary.path,
    settings.path,
  ];
}