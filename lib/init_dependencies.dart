import 'package:get_it/get_it.dart';

import 'api_service/dashboard_api_service.dart';
import 'bloc/dashboard_bloc/dashboard_bloc.dart';
import 'bloc/selected_month_cubit/selected_month_cubit.dart';
import 'core/config/app_config.dart';
import 'core/network/dio_client.dart';
import 'repository/dashboard_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies({required AppConfig config}) async {
  await _registerNetwork();
  await _registerAppCoreDependencies();
  await _registerBusinessCore();
}

Future<void> _registerAppCoreDependencies() async {
  serviceLocator.registerLazySingleton<SelectedMonthCubit>(
    () => SelectedMonthCubit(),
  );
}

Future<void> _registerNetwork() async {
  if (!serviceLocator.isRegistered<DioClient>()) {
    serviceLocator.registerLazySingleton<DioClient>(
      () => DioClient(baseUrl: AppConfig.baseUrl),
    );
  }
}

Future<void> _registerBusinessCore() async {
  serviceLocator
    ..registerLazySingleton<DashboardApiService>(
      () => DashboardApiServiceImpl(dioClient: serviceLocator()),
    )
    ..registerLazySingleton<DashboardRepository>(
      () => DashboardRepositoryImpl(apiService: serviceLocator()),
    )
    ..registerFactory<DashboardBloc>(
      () => DashboardBloc(repository: serviceLocator()),
    );
}
