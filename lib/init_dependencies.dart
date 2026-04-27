import 'package:get_it/get_it.dart';

import 'core/config/app_config.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies({required AppConfig config}) async {
  if (!serviceLocator.isRegistered<AppConfig>()) {
    serviceLocator.registerSingleton<AppConfig>(config);
  }

  await _registerAppCoreDependencies();
}

Future<void> _registerAppCoreDependencies() async {

}
