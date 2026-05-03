import 'package:get_it/get_it.dart';
import 'package:mini_spend_tracker_app/bloc/all_monthly_budgets_cubit/all_monthly_budgets_cubit.dart';
import 'package:mini_spend_tracker_app/bloc/delete_transaction_cubit/delete_transaction_cubit.dart';
import 'package:mini_spend_tracker_app/repository/summary_repository.dart';

import 'api_service/add_expense_api_service.dart';
import 'api_service/settings_api_service.dart';
import 'api_service/summary_api_service.dart';
import 'api_service/transactions_api_service.dart';
import 'bloc/add_expense_cubit/add_expense_cubit.dart';
import 'bloc/categories_summary_cubit/categories_summary_cubit.dart';
import 'bloc/dashboard_bloc/dashboard_bloc.dart';
import 'bloc/selected_month_cubit/selected_month_cubit.dart';
import 'bloc/settings/add_category_cubit/add_category_cubit.dart';
import 'bloc/settings/categories_bloc/categories_bloc.dart';
import 'bloc/settings/delete_category_cubit/delete_category_cubit.dart';
import 'bloc/settings/monthly_budget_cubit/monthly_budget_cubit.dart';
import 'bloc/transactions_bloc/transactions_bloc.dart';
import 'core/config/app_config.dart';
import 'core/network/dio_client.dart';
import 'repository/add_expense_repository.dart';
import 'repository/settings_repository.dart';
import 'repository/transactions_repository.dart';

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
    ..registerLazySingleton<SummaryApiService>(() => SummaryApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<SummaryRepository>(() => SummaryRepositoryImpl(apiService: serviceLocator()))
    ..registerFactory<DashboardBloc>(() => DashboardBloc(repository: serviceLocator()))
    /// Settings
    ..registerLazySingleton<SettingsApiService>(() => SettingsApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl(settingsApiService: serviceLocator()))
    ..registerFactory<MonthlyBudgetCubit>(() => MonthlyBudgetCubit(repository: serviceLocator()))
    ..registerFactory<CategoriesBloc>(() => CategoriesBloc(repository: serviceLocator()))
    ..registerFactory<AddCategoryCubit>(() => AddCategoryCubit(repository: serviceLocator()))
    ..registerFactory<DeleteCategoryCubit>(() => DeleteCategoryCubit(repository: serviceLocator()))
    /// Add Expense
    ..registerLazySingleton<AddExpenseApiService>(() => AddExpenseApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<AddExpenseRepository>(() => AddExpenseRepositoryImpl(addExpenseApiService: serviceLocator()))
    ..registerFactory<AddExpenseCubit>(() => AddExpenseCubit(repository: serviceLocator()))
    /// Transactions
    ..registerLazySingleton<TransactionsApiService>(() => TransactionsApiServiceImpl(dioClient: serviceLocator()))
    ..registerLazySingleton<TransactionsRepository>(() => TransactionsRepositoryImpl(transactionsApiService: serviceLocator()))
    ..registerFactory<TransactionsBloc>(() => TransactionsBloc(repository: serviceLocator()))
    ..registerFactory<DeleteTransactionCubit>(() => DeleteTransactionCubit(repository: serviceLocator()))
      ..registerFactory<AllMonthlyBudgetsCubit>(() => AllMonthlyBudgetsCubit(repository: serviceLocator()))
    /// Categories Summary
    ..registerFactory<CategoriesSummaryCubit>(() => CategoriesSummaryCubit(repository: serviceLocator()));

}
