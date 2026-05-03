import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:mini_spend_tracker_app/repository/summary_repository.dart';

import '../../model/categories_summary_model.dart';

part 'categories_summary_state.dart';

class CategoriesSummaryCubit extends Cubit<CategoriesSummaryState> {
  final SummaryRepository repository;
  CategoriesSummaryCubit({
    required this.repository,
}) : super(CategoriesSummaryInitial());

  Future<void> loadCategoriesSummary({required DateTime month}) async {
    try {
      emit(CategoriesSummaryLoading());
      final monthFormat = DateFormat('yyyy-MM').format(month);
      final result = await repository.getCategoriesSummary(month: monthFormat);
      emit(CategoriesSummaryLoaded(data: result));
    } catch (error) {
      emit(CategoriesSummaryError(message: error.toString()));
    }
  }
}
