import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/model/category_model.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final SettingsRepository repository;

  AddCategoryCubit({required this.repository}) : super(AddCategoryInitial());

  Future<void> addCategory({required String categoryName}) async {
    try {
      emit(AddCategoryLoading());
      final newCategory = await repository.addCategory(categoryName: categoryName);
      emit(AddCategorySuccess(categoryToAdd: newCategory));
    } catch (error) {
      emit(AddCategoryError(message: error.toString()));
    }
  }
}
