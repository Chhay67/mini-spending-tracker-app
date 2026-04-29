import 'package:equatable/equatable.dart';
import 'package:mini_spend_tracker_app/model/add_expense_model.dart';

import '../../core/state/action_state.dart';

class AddExpenseState extends Equatable {
  const AddExpenseState({this.saveState = const ActionInitial(), this.addExpense});

  final ActionState saveState;
  final AddExpenseModel? addExpense;

  AddExpenseState copyWith({ActionState? saveState, AddExpenseModel? addExpense}) {
    return AddExpenseState(saveState: saveState ?? this.saveState, addExpense: addExpense ?? this.addExpense);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [saveState,addExpense];
}
