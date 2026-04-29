import 'package:equatable/equatable.dart';
import 'package:mini_spend_tracker_app/core/state/action_state.dart';

class CategoryModel extends Equatable {
  const CategoryModel({
    this.categoryId,
    required this.categoryName,
    this.color,
    this.active = true,
    this.createdAt,
    this.updatedAt,
    this.deleteState = const ActionInitial(),
  });

  final String? categoryId;
  final String categoryName;
  final String? color;
  final bool active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final ActionState deleteState;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json["category_id"],
      categoryName: json["category_name"] ?? "",
      color: json["color"],
      active: json["active"] ?? true,
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  CategoryModel copyWith({String? categoryId, String? categoryName, bool? active,ActionState? deleteState}) {
    return CategoryModel(
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      active: active ?? this.active,
      deleteState: deleteState ?? this.deleteState,
    );
  }

  Map<String, dynamic> toSaveJson() {
    return {if (categoryId != null) "category_id": categoryId, "category_name": categoryName, "active": active};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [categoryId, categoryName, color, active, createdAt, updatedAt, deleteState];
}
