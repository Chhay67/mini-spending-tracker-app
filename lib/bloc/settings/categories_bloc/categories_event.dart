part of 'categories_bloc.dart';

@immutable
sealed class CategoriesEvent {
    const CategoriesEvent();
}

final class LoadCategoriesEvent extends CategoriesEvent {
  const LoadCategoriesEvent();
}


final class AddCategoryEvent extends CategoriesEvent {
  final CategoryModel category;

  const AddCategoryEvent({required this.category});
}

final class DeleteCategoryEvent extends CategoriesEvent {
  final String categoryId;

  const DeleteCategoryEvent({required this.categoryId});
}

