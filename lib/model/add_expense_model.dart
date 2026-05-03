class AddExpenseModel {
  const AddExpenseModel({this.transactionId, required this.amount, required this.date, this.note, required this.categoryId});
  final String? transactionId;
  final num amount;
  final DateTime date;
  final String? note;
  final String categoryId;
}
