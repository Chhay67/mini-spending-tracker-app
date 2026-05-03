import 'package:mini_spend_tracker_app/model/pagination_model.dart';
import 'package:mini_spend_tracker_app/model/transaction_model.dart';

class TransactionDataModel {
  TransactionDataModel({required this.transactions, required this.pagination});
  final List<TransactionModel> transactions;
  final PaginationModel pagination;

  factory TransactionDataModel.fromJson(Map<String, dynamic> json){
    return TransactionDataModel(

      transactions: json["data"] == null ? [] : List<TransactionModel>.from(json["data"]!.map((x) => TransactionModel.fromJson(x))),
      pagination: json["pagination"] == null ? PaginationModel.initial() : PaginationModel.fromJson(json["pagination"]),
    );
  }

}
