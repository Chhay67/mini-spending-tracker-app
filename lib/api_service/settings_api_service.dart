import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';
import '../model/category_model.dart';
import '../model/monthly_budget_model.dart';

abstract class SettingsApiService {
  Future<MonthlyBudgetModel> getMonthlyBudget({required String month});

  Future<void> savePostMonthlyBudget({required MonthlyBudgetModel monthlyBudget});

  Future<List<MonthlyBudgetModel>> getAllMonthlyBudgets();

  Future<List<CategoryModel>> getCategories();

  Future<CategoryModel> addCategory({required String categoryName});

  Future<void> deleteCategory({required String categoryId});
}

class SettingsApiServiceImpl extends SettingsApiService {
  SettingsApiServiceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'getCategories'});

      return parseOrThrow<List<CategoryModel>>(
        response: response,
        onSuccess: () {
          final responseData = response.data as Map<String, dynamic>;
          final List<dynamic> list = responseData['data'] as List<dynamic>;
          return list.map((item) => CategoryModel.fromJson(item as Map<String, dynamic>)).toList();
        },
      );
    } on DioException catch (error) {
      Logger.error("Error fetching categories: ${error.toString()}");
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      Logger.error("Unknown error fetching categories: ${error.toString()}");
      throw ServerException(error.toString());
    }
  }

  @override
  Future<MonthlyBudgetModel> getMonthlyBudget({required String month}) async {
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'getBudget', 'month': month});

      return parseOrThrow<MonthlyBudgetModel>(
        response: response,
        onSuccess: () {
          if (response.data['data'] == null) {
            return MonthlyBudgetModel.empty();
          }
          return MonthlyBudgetModel.fromJson(response.data['data']);
        },
      );
    } on DioException catch (error) {
      Logger.error("Error fetching getMonthlyBudget: ${error.toString()}");
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      Logger.error("Unknown error fetching getMonthlyBudget: ${error.toString()}");
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> savePostMonthlyBudget({required MonthlyBudgetModel monthlyBudget}) async {
    try {
      if (monthlyBudget.monthKey == null) throw ServerException("monthKey is required for saving monthly budget");
      final response = await dioClient.post(
        "",
        queryParameters: {
          "action": "saveBudget",
          "month_key": DateFormat('yyyy-MM').format(monthlyBudget.monthKey!),
          "budget_amount": monthlyBudget.budgetAmount,
        },
      );
      return parseOrThrow<void>(response: response, onSuccess: () => true);
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<CategoryModel> addCategory({required String categoryName}) async {
    try {
      final response = await dioClient.post("", queryParameters: {"action": "addCategory", "category_name": categoryName});
      return parseOrThrow<CategoryModel>(response: response, onSuccess: () => CategoryModel.fromJson(response.data['data']));
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<void> deleteCategory({required String categoryId}) async {
    try {
      final response = await dioClient.post("", queryParameters: {"action": "deleteCategory", "category_id": categoryId});
      return parseOrThrow<void>(response: response, onSuccess: () => true);
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw ServerException(error.toString());
    }
  }

  @override
  Future<List<MonthlyBudgetModel>> getAllMonthlyBudgets() async {
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'getAllBudgets'});

      return parseOrThrow<List<MonthlyBudgetModel>>(
        response: response,
        onSuccess: () {
          final responseData = response.data as Map<String, dynamic>;
          final List<dynamic> list = responseData['data'] as List<dynamic>;
          return list.map((item) => MonthlyBudgetModel.fromJson(item as Map<String, dynamic>)).toList();
        },
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
