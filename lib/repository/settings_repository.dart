import 'package:flutter/foundation.dart';

import '../api_service/settings_api_service.dart';
import '../model/category_model.dart';
import '../model/monthly_budget_model.dart';

abstract class SettingsRepository {
  Future<MonthlyBudgetModel> getMonthlyBudget({required String month});

  Future<void> saveMonthlyBudget({required MonthlyBudgetModel monthlyBudget});

  Future<List<CategoryModel>> getCategories();

  Future<void> saveCategories({required List<CategoryModel> categories});

  Future<CategoryModel> addCategory({required String categoryName});
  Future<void> deleteCategory({required String categoryId});

}

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl({required this.settingsApiService});

  final SettingsApiService settingsApiService;

  @override
  Future<List<CategoryModel>> getCategories() async {
    return await settingsApiService.getCategories();
  }

  @override
  Future<MonthlyBudgetModel> getMonthlyBudget({required String month}) async {
    return await settingsApiService.getMonthlyBudget(month: month);
  }

  @override
  Future<void> saveCategories({required List<CategoryModel> categories}) async {
    if (kIsWeb) {
      return await settingsApiService.saveGetCategories(categories: categories);
    }
    return await settingsApiService.savePostCategories(categories: categories);
  }

  @override
  Future<void> saveMonthlyBudget({required MonthlyBudgetModel monthlyBudget}) async{
    // if (kIsWeb) {
    //   return await settingsApiService.saveGetMonthlyBudget(monthlyBudget: monthlyBudget);
    // }
    return await settingsApiService.savePostMonthlyBudget(monthlyBudget: monthlyBudget);
  }

  @override
  Future<CategoryModel> addCategory({required String categoryName}) async{
    return await settingsApiService.addCategory(categoryName: categoryName);
  }

  @override
  Future<void> deleteCategory({required String categoryId}) async{
   return await settingsApiService.deleteCategory(categoryId: categoryId);
  }
}
