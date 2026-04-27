import 'package:mini_spend_tracker_app/model/dashboard_model.dart';

import '../api_service/dashboard_api_service.dart';

abstract class DashboardRepository {
  Future<DashboardModel> getDashboardData({required String month});
}

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl({required this.apiService});
  final DashboardApiService apiService;

  @override
  Future<DashboardModel> getDashboardData({required String month}) async {
    return await apiService.getDashboardData(month: month);
  }
}
