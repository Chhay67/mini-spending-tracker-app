part of 'categories_summary_cubit.dart';

@immutable
sealed class CategoriesSummaryState {}

final class CategoriesSummaryInitial extends CategoriesSummaryState {}


final class CategoriesSummaryLoading extends CategoriesSummaryState {}

final class CategoriesSummaryLoaded extends CategoriesSummaryState {
  final CategoriesSummaryModel data;

  CategoriesSummaryLoaded({required this.data});
}

final class CategoriesSummaryError extends CategoriesSummaryState {
  final String message;

  CategoriesSummaryError({required this.message});
}