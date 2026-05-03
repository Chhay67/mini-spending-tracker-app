
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/nav_bar_cubit/nav_bar_cubit.dart';
import '../page/main_scaffold_page.dart';

class AppNavigation {
  AppNavigation._();

  static void navigateToRoute({
    required BuildContext context,
    required String routePath,
      Map<String, String> pathParameters = const {},
      Map<String, String> queryParameters = const {},
    }) {
    final tabs = MainScaffoldPage.tabs;
    final index = tabs.indexWhere((tab) => tab.route.path == routePath);
    if (index != -1) {
      context.read<NavBarCubit>().onChanged(index);
      context.goNamed(
          tabs[index].route.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
    }
  }

}