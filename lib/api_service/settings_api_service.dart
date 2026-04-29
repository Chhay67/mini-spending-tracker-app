import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mini_spend_tracker_app/core/utils/logger.dart';

import '../core/exception/app_exception.dart';
import '../core/network/dio_client.dart';
import '../model/category_model.dart';
import '../model/monthly_budget_model.dart';

abstract class SettingsApiService {
  Future<MonthlyBudgetModel> getMonthlyBudget({required String month});

  Future<void> savePostMonthlyBudget({required MonthlyBudgetModel monthlyBudget});

  Future<void> saveGetMonthlyBudget({required MonthlyBudgetModel monthlyBudget});

  Future<List<CategoryModel>> getCategories();

  Future<void> savePostCategories({required List<CategoryModel> categories});

  Future<void> saveGetCategories({required List<CategoryModel> categories});

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
      final response = await dioClient.get("", queryParameters: {'action': 'budget', 'month': month});
      return MonthlyBudgetModel.fromJson(response.data);
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> savePostCategories({required List<CategoryModel> categories}) async {
    try {
      final response = await dioClient.post(
        "",
        data: {
          'action': 'saveCategories',
          'data': jsonEncode({'categories': categories.map((category) => category.toSaveJson()).toList()}),
        },
      );
      return parseOrThrow<void>(response: response, onSuccess: () {});
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> saveGetCategories({required List<CategoryModel> categories}) async {
    try {
      final response = await dioClient.get(
        "",
        queryParameters: {
          'action': 'saveCategories',
          'data': jsonEncode({'categories': categories.map((category) => category.toSaveJson()).toList()}),
        },
      );
      return parseOrThrow<void>(response: response, onSuccess: () {});
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> saveGetMonthlyBudget({required MonthlyBudgetModel monthlyBudget}) async {
    try {
      await dioClient.get(
        "",
        queryParameters: {"action": "saveBudget", "month": monthlyBudget.month, "monthlyBudget": monthlyBudget.monthlyBudget},
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> savePostMonthlyBudget({required MonthlyBudgetModel monthlyBudget}) async {
    try {
      await dioClient.post(
        "",
        data: jsonEncode({"action": "saveBudget", "month": monthlyBudget.month, "monthlyBudget": monthlyBudget.monthlyBudget}),
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<CategoryModel> addCategory({required String categoryName}) async {
    try {
      final response = await dioClient.post(
        "",
        queryParameters: {
          "action": "addCategory",
          "category_name": categoryName,
        },
      );
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
      final response = await dioClient.post("", queryParameters: {
        "action": "deleteCategory",
        "category_id": categoryId,
      },);
      return parseOrThrow<void>(response: response, onSuccess: () => true);
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
}
