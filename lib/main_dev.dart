import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:mini_spend_tracker_app/core/enum/flavor.dart';
import 'package:mini_spend_tracker_app/root_app.dart';

import 'core/config/app_config.dart';
import 'core/utils/logger.dart';
import 'init_dependencies.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      setUrlStrategy(PathUrlStrategy());
      AppConfig.init(flavor: FlavorEnum.dev);
      await initDependencies(config: AppConfig.instance);
      await Firebase.initializeApp(options: AppConfig.firebaseOptions);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      runApp(const RootApp());
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
