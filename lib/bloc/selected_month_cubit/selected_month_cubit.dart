import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedMonthCubit extends Cubit<DateTime> {
  SelectedMonthCubit() : super(DateTime.now());

  void onMonthChanged({required DateTime newMonth}) {
    emit(newMonth);
  }

  void onClickNextMonth() {
    emit(_addMonths(state, 1));
  }

  void onClickPreviousMonth() {
    emit(_addMonths(state, -1));
  }

  DateTime _addMonths(DateTime date, int months) {
    final targetFirstDay = DateTime(date.year, date.month + months, 1);
    final daysInTargetMonth =
        DateTime(targetFirstDay.year, targetFirstDay.month + 1, 0).day;
    final clampedDay =
        date.day > daysInTargetMonth ? daysInTargetMonth : date.day;

    return DateTime(
      targetFirstDay.year,
      targetFirstDay.month,
      clampedDay,
      date.hour,
      date.minute,
      date.second,
      date.millisecond,
      date.microsecond,
    );
  }
}
