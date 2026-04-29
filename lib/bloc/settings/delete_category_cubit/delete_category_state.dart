part of 'delete_category_cubit.dart';

class DeleteCategoryState extends Equatable {
  const DeleteCategoryState({this.deleteCategoryStates = const []});

  final List<({ActionState action, String categoryId})> deleteCategoryStates;

  @override
  // TODO: implement props
  List<Object?> get props => [deleteCategoryStates];
}
