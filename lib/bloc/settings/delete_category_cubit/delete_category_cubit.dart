import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:mini_spend_tracker_app/repository/settings_repository.dart';

import '../../../core/state/action_state.dart';

part 'delete_category_state.dart';

class DeleteCategoryCubit extends Cubit<DeleteCategoryState> {
  final SettingsRepository repository;

  DeleteCategoryCubit({required this.repository}) : super(DeleteCategoryState());

  Future<void> deleteCategory({required String categoryId}) async {
    try {
      final currentState = state;
      final existingCategoryState = currentState.deleteCategoryStates.firstWhereOrNull((state) => state.categoryId == categoryId);

      final ({ActionState action, String categoryId}) deleteCategoryState = (action: const ActionLoading(), categoryId: categoryId);
    } catch (error) {}
  }
}
