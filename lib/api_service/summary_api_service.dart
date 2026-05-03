import 'package:dio/dio.dart';
import 'package:mini_spend_tracker_app/core/exception/app_exception.dart';
import 'package:mini_spend_tracker_app/core/network/dio_client.dart';

import '../model/categories_summary_model.dart';
import '../model/dashboard_model.dart';

abstract class SummaryApiService {
  Future<DashboardModel> getDashboardSummary({required String month});

  Future<CategoriesSummaryModel> getCategoriesSummary({required String month});
}

class SummaryApiServiceImpl extends SummaryApiService {
  SummaryApiServiceImpl({required this.dioClient});
  final DioClient dioClient;

  @override
  Future<DashboardModel> getDashboardSummary({required String month}) async {
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'getDashboardSummary', 'month': month});
      return parseOrThrow<DashboardModel>(response: response, onSuccess: () => DashboardModel.fromJson(response.data['data']));
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }

  @override
  Future<CategoriesSummaryModel> getCategoriesSummary({required String month}) async{
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'getCategorySummary', 'month': month});
      return parseOrThrow<CategoriesSummaryModel>(response: response, onSuccess: () => CategoriesSummaryModel.fromJson(response.data['data']));
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }
}
