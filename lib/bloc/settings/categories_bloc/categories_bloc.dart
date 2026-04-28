import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

import '../../../core/state/save_state.dart';
import '../../../model/category_model.dart';

part 'categories_event.dart';

part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final SettingsRepository repository;

  CategoriesBloc({required this.repository}) : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>((_loadCategories));
    on<AddCategoryEvent>(_addCategory);
    on<SaveCategoriesEvent>((_saveCategories));
    on<DeleteCategoryEvent>((_deleteCategory));
  }

  FutureOr<void> _loadCategories(LoadCategoriesEvent event, Emitter<CategoriesState> emit) async {
    try {
      emit(CategoriesLoading());
      final resultCategories = await repository.getCategories();
      emit(CategoriesLoaded(categories: resultCategories));
    } catch (error) {
      emit(CategoriesError(message: error.toString()));
    }
  }

  FutureOr<void> _addCategory(AddCategoryEvent event, Emitter<CategoriesState> emit) {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      final currentCategories = currentState.categories;
      final newCategory = CategoryModel(
        name: event.categoryName,
        categoryId: DateTime.now().millisecondsSinceEpoch.toString(),
        color: '',
        active: true,
      );
      final updatedCategories = List<CategoryModel>.from(currentCategories)..insert(0, newCategory);
      emit(CategoriesLoaded(categories: updatedCategories));
    }
  }

  FutureOr<void> _saveCategories(SaveCategoriesEvent event, Emitter<CategoriesState> emit) async {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      try {
        emit(currentState.copyWith(saveState: const SaveLoading()));
        await repository.saveCategories(categories: currentState.categories);
        emit(currentState.copyWith(saveState: const SaveSuccess()));
      } catch (error) {
        emit(currentState.copyWith(saveState: SaveError(message: error.toString())));
      }
    }
  }

  FutureOr<void> _deleteCategory(DeleteCategoryEvent event, Emitter<CategoriesState> emit) async{
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      final currentCategories = currentState.categories;
      final updatedCategories = currentCategories.where((category) => category.categoryId != event.categoryId).toList();
      emit(CategoriesLoaded(categories: updatedCategories));
    }
  }
}
