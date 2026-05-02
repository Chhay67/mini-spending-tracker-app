part of 'delete_category_cubit.dart';

@immutable
sealed class DeleteCategoryState {}

final class DeleteCategoryInitial extends DeleteCategoryState {}


final class DeleteCategoryLoading extends DeleteCategoryState{}


final class DeleteCategorySuccess extends DeleteCategoryState{

  final CategoryModel categoryToDelete;

  DeleteCategorySuccess({required this.categoryToDelete});
}

final class DeleteCategoryError extends DeleteCategoryState{
  DeleteCategoryError({required this.errorMessage});

  final String errorMessage;
}