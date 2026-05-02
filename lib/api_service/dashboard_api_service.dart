import 'package:dio/dio.dart';
import 'package:mini_spend_tracker_app/core/exception/app_exception.dart';
import 'package:mini_spend_tracker_app/core/network/dio_client.dart';

import '../model/dashboard_model.dart';

abstract class DashboardApiService {
  Future<DashboardModel> getDashboardData({required String month});
}

class DashboardApiServiceImpl extends DashboardApiService {
  DashboardApiServiceImpl({required this.dioClient});
  final DioClient dioClient;

  @override
  Future<DashboardModel> getDashboardData({required String month}) async {
    try {
      final response = await dioClient.get("", queryParameters: {'action': 'getDashboardSummary', 'month': month});
      return parseOrThrow<DashboardModel>(response: response, onSuccess: () => DashboardModel.fromJson(response.data['data']));
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }
}
