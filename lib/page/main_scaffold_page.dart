import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_spend_tracker_app/bloc/nav_bar_cubit/nav_bar_cubit.dart';
import 'package:mini_spend_tracker_app/core/config/app_config.dart';
import 'package:mini_spend_tracker_app/core/theme/app_colors.dart';
import 'package:mini_spend_tracker_app/route/routes.dart';

import '../bloc/selected_month_cubit/selected_month_cubit.dart';
import '../init_dependencies.dart';

class MainScaffoldPage extends StatelessWidget {
  const MainScaffoldPage({super.key, required this.child,this.initNavBarIndex});

  final Widget child;
  final int? initNavBarIndex;
  static const tabs = [
    (icon: Icons.dashboard_outlined, label: 'Dashboard', route: Routes.dashboard),
    (icon: Icons.receipt_long_outlined, label: 'Transactions', route: Routes.transactions),
    (icon: Icons.add_circle_outline, label: 'Add', route: Routes.addExpense),
    (icon: Icons.bar_chart, label: 'Summary', route: Routes.categorySummary),

    (icon: Icons.settings_outlined, label: 'Settings', route: Routes.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => NavBarCubit()..init(initIndex: initNavBarIndex)),
      BlocProvider(create: (_) => serviceLocator<SelectedMonthCubit>()),
    ], child: BlocBuilder<NavBarCubit, int>(builder: (context, selectedIndex) {
      return Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/icon/icon.png", cacheHeight: 150, cacheWidth: 150, filterQuality: FilterQuality.high),
          centerTitle: false,
          title: Text(AppConfig.appName, style: textTheme.titleLarge?.copyWith(color: AppColors.primary)),
        ),
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          currentIndex: selectedIndex,
          onTap: (index) {
            context.read<NavBarCubit>().onChanged(index);
            context.go(tabs[index].route.path);
          },
          items: tabs
              .map((tab) => BottomNavigationBarItem(icon: Icon(tab.icon), label: tab.label))
              .toList(growable: false),
        ),
      );
    },));

  }
}
