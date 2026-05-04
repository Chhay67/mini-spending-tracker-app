import 'package:mini_spend_tracker_app/model/dashboard_model.dart';

import '../api_service/summary_api_service.dart';
import '../core/enum/filter_type_enum.dart';
import '../model/categories_summary_model.dart';


abstract class SummaryRepository {
  Future<DashboardModel> getDashboardSummary({required String month});
  Future<CategoriesSummaryModel> getCategoriesSummary({required DateTime date, FilterTypeEnum filterType = FilterTypeEnum.month});

}

class SummaryRepositoryImpl extends SummaryRepository {
  SummaryRepositoryImpl({required this.apiService});
  final SummaryApiService apiService;

   @override
  Future<DashboardModel> getDashboardSummary({required String month}) async {
    return await apiService.getDashboardSummary(month: month);
  }

  @override
  Future<CategoriesSummaryModel> getCategoriesSummary({required DateTime date, FilterTypeEnum filterType = FilterTypeEnum.month}) async{
    return await apiService.getCategoriesSummary(date: date, filterType: filterType);
  }


}
