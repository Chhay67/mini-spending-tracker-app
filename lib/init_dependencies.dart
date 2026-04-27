import 'package:get_it/get_it.dart';

import 'bloc/selected_month_cubit/selected_month_cubit.dart';
import 'core/config/app_config.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies({required AppConfig config}) async {
  if (!serviceLocator.isRegistered<AppConfig>()) {
    serviceLocator.registerSingleton<AppConfig>(config);
  }

  await _registerAppCoreDependencies();
}

Future<void> _registerAppCoreDependencies() async {
  serviceLocator.registerLazySingleton<SelectedMonthCubit>(
    () => SelectedMonthCubit(),
  );
}
