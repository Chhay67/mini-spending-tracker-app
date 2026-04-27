import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/model/dashboard_model.dart';
import 'package:mini_spend_tracker_app/repository/dashboard_repository.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;
  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<LoadDashboardDataEvent>(_loadDashboardData);
  }

  FutureOr<void> _loadDashboardData(
    LoadDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(const DashboardLoading());
      final monthFormat = DateFormat('yyyy-MM').format(event.month);
      final result = await repository.getDashboardData(month: monthFormat);
      emit(DashboardLoaded(data: result));
    } catch (error) {
      emit(DashboardError(message: error.toString()));
    }
  }
}
