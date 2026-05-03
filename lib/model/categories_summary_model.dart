

class CategoriesSummaryModel {
  CategoriesSummaryModel({
    required this.monthKey,
    required this.totalSpent,
    required this.categories,
});
  final String monthKey;
  final num totalSpent;
  final List<CategorySummaryModel> categories;

  factory CategoriesSummaryModel.fromJson(Map<String, dynamic> json){
    return CategoriesSummaryModel(
      monthKey: json["month_key"] ?? "",
      totalSpent: json["total_spent"] ?? 0,
      categories: json["categories"] == null ? [] : List<CategorySummaryModel>.from(json["categories"]!.map((x) => CategorySummaryModel.fromJson(x))),
    );
  }

}


class CategorySummaryModel {
  final String categoryId;
  final String categoryName;
  final String categoryColor;
  final num totalSpent;
  final num percent;

  CategorySummaryModel({
    required this.categoryName,
    required this.categoryColor,
    required this.totalSpent,
    required this.percent,
    required this.categoryId,
  });

  factory CategorySummaryModel.fromJson(Map<String, dynamic> json) {
    return CategorySummaryModel(
      categoryId: json["category_id"] ?? "",
      categoryName: json["category_name"] ?? "",
      categoryColor: json["category_color"] ?? "",
      totalSpent: json["total_spent"] ?? 0,
      percent: json["percent"] ?? 0,
    );
  }
}