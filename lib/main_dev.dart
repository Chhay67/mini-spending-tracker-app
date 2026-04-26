import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:mini_spend_tracker_app/core/enum/flavor.dart';
import 'package:mini_spend_tracker_app/root_app.dart';

import 'core/config/app_config.dart';
import 'core/theme/app_themes.dart';
import 'core/utils/logger.dart';

void main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setSystemUIOverlayStyle();
      setUrlStrategy(PathUrlStrategy());
      AppConfig.init(flavor: Flavor.dev);
      // await Firebase.initializeApp(options: AppConfig.firebaseOptions);
      runApp(RootApp());
    },
    (error, stackTrace) {
      Logger.error(
        error.toString(),
        title: "App level error",
        stackTrace: stackTrace,
      );
    },
  );
}
