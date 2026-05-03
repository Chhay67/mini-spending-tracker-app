

class TransactionModel {
    TransactionModel({
      required this.transactionId,
      required this.budgetId,
      required this.categoryId,
      required this.categoryName,
      required this.date,
      required this.monthKey,
      required this.amount,
      required this.currency,
      required this.note,
      required this.createdAt,
      required this.updatedAt,
      required this.categoryColor,
    });


  final String transactionId;
  final String budgetId;
  final String categoryId;
  final String categoryName;
  final DateTime? date;
  final DateTime? monthKey;
  final num amount;
  final String currency;
  final String note;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String categoryColor;

    factory TransactionModel.fromJson(Map<String, dynamic> json){
      String note = "";
      if(json["note"] != null) {
        note = json["note"].toString();
      }
      return TransactionModel(
        transactionId: json["transaction_id"] ?? "",
        budgetId: json["budget_id"] ?? "",
        categoryId: json["category_id"] ?? "",
        categoryName: json["category_name"] ?? "",
        date: DateTime.tryParse(json["date"] ?? ""),
        monthKey: DateTime.tryParse(json["month_key"] ?? ""),
        amount: json["amount"] ?? 0,
        currency: json["currency"] ?? "",
        note: note,
        createdAt: DateTime.tryParse(json["created_at"] ?? ""),
        updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
        categoryColor: json["category_color"] ?? "",
      );
    }
}