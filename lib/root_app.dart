import 'package:flutter/material.dart';
import 'package:mini_spend_tracker_app/core/config/app_config.dart';
import 'package:mini_spend_tracker_app/core/theme/app_themes.dart';
import 'package:mini_spend_tracker_app/route/app_go_router.dart';

class RootApp extends StatefulWidget {
  const RootApp({super.key});

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/icon/icon.png"), context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      theme: AppThemes.lightMode,
      routerConfig: AppGoRouter.router,
      builder: (context, child) => child!,
    );
  }
}
