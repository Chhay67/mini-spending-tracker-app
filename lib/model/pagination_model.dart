
import 'package:equatable/equatable.dart';

class PaginationModel extends Equatable{

  const PaginationModel({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrev,
  });
  final num page;
  final num limit;
  final num total;
  final num totalPages;
  final bool hasNext;
  final bool hasPrev;
  factory PaginationModel.fromJson(Map<String, dynamic> json){
    return PaginationModel(
      page: json["page"] ?? 0,
      limit: json["limit"] ?? 0,
      total: json["total"] ?? 0,
      totalPages: json["total_pages"] ?? 0,
      hasNext: json["has_next"] ?? false,
      hasPrev: json["has_prev"] ?? false,
    );
  }

  factory PaginationModel.initial() {
    return const PaginationModel(
      page: 1,
      limit: 10,
      total: 0,
      totalPages: 0,
      hasNext: false,
      hasPrev: false,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [page, limit, total, totalPages, hasNext, hasPrev];

}