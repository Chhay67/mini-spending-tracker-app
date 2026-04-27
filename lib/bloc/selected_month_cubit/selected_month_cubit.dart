import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedMonthCubit extends Cubit<DateTime> {
  SelectedMonthCubit() : super(DateTime.now());

  void onMonthChanged({required DateTime newMonth}) {
    emit(newMonth);
  }

  void onClickNextMonth() {
    final currentMonth = state;
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    emit(nextMonth);
  }

  void onClickPreviousMonth() {
    final currentMonth = state;
    final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    emit(previousMonth);
  }
}
