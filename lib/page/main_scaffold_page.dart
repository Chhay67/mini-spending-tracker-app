import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/bloc/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:mini_spend_tracker_app/core/config/app_config.dart';
import 'package:mini_spend_tracker_app/route/routes.dart';

class MainScaffoldPage extends StatefulWidget {
  const MainScaffoldPage({super.key, required this.child});

  final Widget child;

  static const tabs = [
    (icon: Icons.add_circle_outline, label: 'Add', route: Routes.addExpense),
    (
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      route: Routes.dashboard,
    ),
    (
      icon: Icons.receipt_long_outlined,
      label: 'Transactions',
      route: Routes.transactions,
    ),
    (icon: Icons.bar_chart, label: 'Summary', route: Routes.categorySummary),

    (icon: Icons.settings_outlined, label: 'Settings', route: Routes.settings),
  ];

  @override
  State<MainScaffoldPage> createState() => _MainScaffoldPageState();
}

class _MainScaffoldPageState extends State<MainScaffoldPage> {


  late GoRouter _router;
  bool _listenerAttached = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // GoRouter is available via InheritedWidget, so we grab it here.
    // Guard ensures the listener is only attached once even if
    // didChangeDependencies is called multiple times.
    if (!_listenerAttached) {
      _listenerAttached = true;
      _router = GoRouter.of(context);
      _router.routerDelegate.addListener(_syncNavBarWithRouter);
    }
  }

  @override
  void dispose() {
    _router.routerDelegate.removeListener(_syncNavBarWithRouter);
    super.dispose();
  }

  /// Called by GoRouter whenever the route changes for any reason
  /// (back button, deep link, programmatic navigation, etc.)
  void _syncNavBarWithRouter() {
    if (!mounted) return;
    final location = _router.routerDelegate.currentConfiguration.uri.path;
    final index = MainScaffoldPage.tabs.indexWhere((tab) => tab.route.path == location);
    if (index != -1) {
      context.read<NavBarCubit>().onChanged(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavBarCubit, int>(
      builder: (context, selectedIndex) {
        return Scaffold(
          appBar: AppBar(centerTitle: false, title: Text(AppConfig.appName)),
          body: widget.child,
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            currentIndex: selectedIndex,
            onTap: (index) {
              context.read<NavBarCubit>().onChanged(index);
              context.go(MainScaffoldPage.tabs[index].route.path);
            },
            items: MainScaffoldPage.tabs
                .map(
                  (tab) => BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    label: tab.label,
                  ),
                )
                .toList(growable: false),
          ),
        );
      },
    );
  }
}
