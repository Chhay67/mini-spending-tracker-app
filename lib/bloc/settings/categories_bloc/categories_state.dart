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
  final SaveState saveState;

  CategoriesLoaded({required this.categories, this.saveState = const SaveInitial()});

  CategoriesLoaded copyWith({List<CategoryModel>? categories, SaveState? saveState}) {
    return CategoriesLoaded(categories: categories ?? this.categories, saveState: saveState ?? this.saveState);
  }

  @override
  List<Object?> get props => [categories, saveState];
}

final class CategoriesError extends CategoriesState {
  final String message;

  CategoriesError({required this.message});

  @override
  List<Object?> get props => [message];
}
