import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class AddExpenseModel extends Equatable {
  const AddExpenseModel({required this.amount, required this.date, this.note, required this.category});

  final num amount;
  final DateTime date;
  final String? note;
  final String category;

  AddExpenseModel copyWith({num? amount, DateTime? date, String? note, String? category}) {
    return AddExpenseModel(
      amount: amount ?? this.amount,
      date: date ?? this.date,
      note: note ?? this.note,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toAddExpenseJson() => {
    "action": "addExpense",
    "date": DateFormat("yyyy-MM-dd").format(date),
    "category": category,
    "amount": amount,
    "note": note,
  };

  @override
  // TODO: implement props
  List<Object?> get props =>  [amount, date, note, category];
}
