import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/model/category_model.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  
  final SettingsRepository repository;
  DeleteCategoryCubit({
    required this.repository,
}) : super(DeleteCategoryInitial());
  
  
  Future<void> deleteCategory({required CategoryModel categoryToDelete}) async{
    try{
      if(categoryToDelete.categoryId == null ) return;
      emit(DeleteCategoryLoading());
      await repository.deleteCategory(categoryId: categoryToDelete.categoryId!);

      emit(DeleteCategorySuccess(categoryToDelete: categoryToDelete));
    }catch(error){
      emit(DeleteCategoryError(errorMessage: error.toString()));
    }
  }
}
