
class AddExpenseModel {
  const AddExpenseModel({required this.amount, required this.date, this.note, required this.categoryId});

  final num amount;
  final DateTime date;
  final String? note;
  final String categoryId;
}
