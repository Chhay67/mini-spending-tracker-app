import 'package:equatable/equatable.dart';
import 'package:mini_spend_tracker_app/model/add_expense_model.dart';

import '../../core/state/save_state.dart';

class AddExpenseState extends Equatable {
  const AddExpenseState({this.saveState = const SaveInitial(), this.addExpense});

  final SaveState saveState;
  final AddExpenseModel? addExpense;

  AddExpenseState copyWith({SaveState? saveState, AddExpenseModel? addExpense}) {
    return AddExpenseState(saveState: saveState ?? this.saveState, addExpense: addExpense ?? this.addExpense);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [saveState,addExpense];
}
