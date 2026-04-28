import 'dart:convert';

import 'package:dio/dio.dart';

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
}

class SettingsApiServiceImpl extends SettingsApiService {
  SettingsApiServiceImpl({required this.dioClient});

  final DioClient dioClient;

  @override
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'categories'});
      final responseData = response.data as Map<String, dynamic>;
      final List<dynamic> list = responseData['data'] as List<dynamic>;
      return list.map((item) => CategoryModel.fromJson(item as Map<String, dynamic>)).toList();
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
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
      await dioClient.post(
        "",
        data: jsonEncode({"action": "saveCategories", "categories": categories.map((category) => category.toSaveJson()).toList()}),
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> saveGetCategories({required List<CategoryModel> categories}) async {
    try {
      await dioClient.get(
        "",
        queryParameters: {
          'action': 'saveCategories',
          'categories': jsonEncode(categories.map((category) => category.toSaveJson()).toList()),
        },
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }



  @override
  Future<void> saveGetMonthlyBudget({required MonthlyBudgetModel monthlyBudget})async {
    try {
      await dioClient.get(
        "",
        queryParameters: {
          "action": "saveBudget",
          "month": monthlyBudget.month,
          "monthlyBudget": monthlyBudget.monthlyBudget,
        },
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<void> savePostMonthlyBudget({required MonthlyBudgetModel monthlyBudget}) async{
    try {
      await dioClient.post(
        "",
        data: jsonEncode({
          "action": "saveBudget",
          "month": monthlyBudget.month,
          "monthlyBudget": monthlyBudget.monthlyBudget,
        }),
        options: Options(contentType: Headers.textPlainContentType, responseType: ResponseType.json),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }
}
