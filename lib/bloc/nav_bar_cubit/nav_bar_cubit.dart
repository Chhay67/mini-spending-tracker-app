import 'package:flutter_bloc/flutter_bloc.dart';

import '../../page/main_scaffold_page.dart';
import '../../route/routes.dart';

class NavBarCubit extends Cubit<int> {
  NavBarCubit() : super(0);

  void init({int? initIndex}) {
    if(initIndex != null) {
      emit(initIndex);
      return;
    }
    final index = MainScaffoldPage.tabs.indexWhere((tab) => tab.route.path == Routes.addExpense.path);
    emit(index);
  }

  void onChanged(int index) {
    emit(index);
  }
}
