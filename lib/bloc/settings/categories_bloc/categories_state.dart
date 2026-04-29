part of 'categories_bloc.dart';

@immutable
sealed class CategoriesState extends Equatable {}

final class CategoriesInitial extends CategoriesState {
  @override
  List<Object?> get props => [];
}

final class CategoriesLoading extends CategoriesState {
  @override
  List<Object?> get props => [];
}

final class CategoriesLoaded extends CategoriesState {
  final List<CategoryModel> categories;


  CategoriesLoaded({
    required this.categories,
  });

  CategoriesLoaded copyWith({List<CategoryModel>? categories, }) {
    return CategoriesLoaded(
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [categories, ];
}

final class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError({required this.message});

  @override
  List<Object?> get props => [message];
}
