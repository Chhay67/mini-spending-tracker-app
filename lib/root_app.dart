import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/core/config/app_config.dart';
import 'package:mini_spend_tracker_app/core/theme/app_themes.dart';
import 'package:mini_spend_tracker_app/route/app_go_router.dart';

import 'bloc/nav_bar_cubit/nav_bar_cubit.dart';
import 'bloc/selected_month_cubit/selected_month_cubit.dart';
import 'init_dependencies.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavBarCubit()),
        BlocProvider(create: (_) => serviceLocator<SelectedMonthCubit>()),
      ],
      child: MaterialApp.router(
        title: AppConfig.appName,
        theme: AppThemes.lightMode,
        routerConfig: AppGoRouter.router,
        builder: (context, child) => child!,
      ),
    );
  }
}
