part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class LoadDashboardDataEvent extends DashboardEvent{
  final DateTime month;
  LoadDashboardDataEvent({required this.month});
}