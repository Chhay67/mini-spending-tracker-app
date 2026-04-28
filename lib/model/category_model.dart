class CategoryModel {
  CategoryModel({required this.categoryId, required this.name, required this.color, required this.active});

  final String categoryId;
  final String name;
  final String color;
  final bool active;

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryId: json["categoryId"] ?? "",
      name: json["name"] ?? "",
      color: json["color"] ?? "",
      active: json["active"] ?? false,
    );
  }


  Map<String, dynamic> toSaveJson() =>{
    "name": name,
    "active": true
  };

  Map<String, dynamic> toUpdateCategoryJson() => {"action": "updateCategory", "categoryId": categoryId, "name": name, "active": true};

  Map<String, dynamic> toDeleteCategoryJson() => {"action": "deleteCategory", "categoryId": categoryId};
}
