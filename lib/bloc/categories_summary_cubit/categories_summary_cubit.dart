import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_spend_tracker_app/core/enum/filter_type_enum.dart';
import 'package:mini_spend_tracker_app/repository/summary_repository.dart';

import '../../model/categories_summary_model.dart';

part 'categories_summary_state.dart';

class CategoriesSummaryCubit extends Cubit<CategoriesSummaryState> {
  final SummaryRepository repository;
  CategoriesSummaryCubit({
    required this.repository,
}) : super(CategoriesSummaryInitial());

  Future<void> loadCategoriesSummary({required DateTime date,FilterTypeEnum filterType = FilterTypeEnum.month}) async {
    try {
      emit(CategoriesSummaryLoading());
      final result = await repository.getCategoriesSummary(date: date, filterType: filterType);
      emit(CategoriesSummaryLoaded(data: result));
    } catch (error) {
      emit(CategoriesSummaryError(message: error.toString()));
    }
  }
}
