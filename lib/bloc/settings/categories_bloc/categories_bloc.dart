import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

import '../../../model/category_model.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final SettingsRepository repository;

  CategoriesBloc({required this.repository}) : super(CategoriesInitial()) {
    on<LoadCategoriesEvent>((_loadCategories));
    on<AddCategoryEvent>(_addCategory);
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

  FutureOr<void> _addCategory(AddCategoryEvent event, Emitter<CategoriesState> emit) async {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      final updatedCategories = List<CategoryModel>.from(currentState.categories)..insert(0, event.category);
      emit(currentState.copyWith(categories: updatedCategories));
    }
  }

  FutureOr<void> _deleteCategory(DeleteCategoryEvent event, Emitter<CategoriesState> emit) async {
    final currentState = state;
    if (currentState is CategoriesLoaded) {
      final categoryToDelete = currentState.categories.firstWhereOrNull((category) => category.categoryId == event.categoryId);
      if (categoryToDelete == null) return;
      final updatedCategories = currentState.categories.where((category) => category.categoryId != categoryToDelete.categoryId).toList();
      emit(currentState.copyWith(categories: updatedCategories));
    }
  }
}
