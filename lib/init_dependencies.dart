import 'package:get_it/get_it.dart';

import 'api_service/add_expense_api_service.dart';
import 'api_service/dashboard_api_service.dart';
import 'api_service/settings_api_service.dart';
import 'bloc/add_expense_cubit/add_expense_cubit.dart';
import 'bloc/dashboard_bloc/dashboard_bloc.dart';
import 'bloc/selected_month_cubit/selected_month_cubit.dart';
import 'bloc/settings/categories_bloc/categories_bloc.dart';
import 'bloc/settings/monthly_budget_cubit/monthly_budget_cubit.dart';
import 'core/config/app_config.dart';
import 'core/network/dio_client.dart';
import 'repository/add_expense_repository.dart';
import 'repository/dashboard_repository.dart';
import 'repository/settings_repository.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies({required AppConfig config}) async {
  await _registerNetwork();
  await _registerAppCoreDependencies();
  await _registerBusinessCore();
}

Future<void> _registerAppCoreDependencies() async {
  serviceLocator.registerLazySingleton<SelectedMonthCubit>(() => SelectedMonthCubit());
}

Future<void> _registerNetwork() async {
  if (!serviceLocator.isRegistered<DioClient>()) {
    serviceLocator.registerLazySingleton<DioClient>(() => DioClient(baseUrl: AppConfig.baseUrl));
  }
}

Future<void> _registerBusinessCore() async {
  /// Dashboard
  serviceLocator
    ..registerLazySingleton<DashboardApiService>(() => DashboardApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(apiService: serviceLocator()))
    ..registerFactory<DashboardBloc>(() => DashboardBloc(repository: serviceLocator()))
    /// Settings
    ..registerLazySingleton<SettingsApiService>(() => SettingsApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(settingsApiService: serviceLocator()))
    ..registerFactory<MonthlyBudgetCubit>(() => MonthlyBudgetCubit(repository: serviceLocator()))
    ..registerFactory<CategoriesBloc>(() => CategoriesBloc(repository: serviceLocator()))
    /// Add Expense
    ..registerLazySingleton<AddExpenseApiService>(() => AddExpenseApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<AddExpenseRepository>(() => AddExpenseRepositoryImpl(addExpenseApiService: serviceLocator()))
    ..registerFactory<AddExpenseCubit>(() => AddExpenseCubit(repository: serviceLocator()));
}
