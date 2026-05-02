part of 'add_category_cubit.dart';

@immutable
sealed class AddCategoryState {}

final class AddCategoryInitial extends AddCategoryState {}

final class AddCategoryLoading extends AddCategoryState {}

final class AddCategorySuccess extends AddCategoryState {
  final CategoryModel categoryToAdd;
  AddCategorySuccess({required this.categoryToAdd});
}

final class AddCategoryError extends AddCategoryState {
  final String message;

  AddCategoryError({required this.message});
}
