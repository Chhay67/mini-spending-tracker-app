import 'package:flutter_bloc/flutter_bloc.dart';

import '../../page/main_scaffold_page.dart';
import '../../route/routes.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(_getInitialIndex());

  static int _getInitialIndex() {
    final index = MainScaffoldPage.tabs.indexWhere((tab) => tab.route.path == Routes.addExpense.path);
    return index != -1 ? index : 0;
  }

  void onChanged(int index) {
    emit(index);
  }
}
