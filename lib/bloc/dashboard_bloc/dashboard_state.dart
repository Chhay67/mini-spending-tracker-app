part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded({required this.data});
  final DashboardModel data;
}

final class DashboardError extends DashboardState {
  final String message;
  const DashboardError({required this.message});
}
