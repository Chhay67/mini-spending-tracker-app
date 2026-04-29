import 'dart:async';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

import '../../../core/state/action_state.dart';
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
      final updatedCategories = currentState.categories.map((category) {
        if (category.categoryId == event.categoryId) {
          return category.copyWith(deleteState: const ActionLoading());
        }
        return category;
      }).toList();
      emit(currentState.copyWith(categories: updatedCategories));
      try {
        await repository.deleteCategory(categoryId: event.categoryId);
        final updatedCategories = currentState.categories.where((category) => category.categoryId != event.categoryId).toList();
        emit(currentState.copyWith(categories: updatedCategories));
      } catch (error) {
        final updatedCategories = currentState.categories.map((category) {
          if (category.categoryId == event.categoryId) {
            return category.copyWith(deleteState: ActionError(message: error.toString()));
          }
          return category;
        }).toList();
        emit(currentState.copyWith(categories: updatedCategories));
      }
    }
  }
}
