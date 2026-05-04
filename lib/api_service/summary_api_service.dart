import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:mini_spend_tracker_app/core/enum/filter_type_enum.dart';
import 'package:mini_spend_tracker_app/core/exception/app_exception.dart';
import 'package:mini_spend_tracker_app/core/network/dio_client.dart';

import '../model/categories_summary_model.dart';
import '../model/dashboard_model.dart';

abstract class SummaryApiService {
  Future<DashboardModel> getDashboardSummary({required String month});

  Future<CategoriesSummaryModel> getCategoriesSummary({required DateTime date, FilterTypeEnum filterType = FilterTypeEnum.month});
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
  Future<CategoriesSummaryModel> getCategoriesSummary({required DateTime date, FilterTypeEnum filterType = FilterTypeEnum.month}) async {
    try {
      final Map<String,dynamic> queryParameters = {
        'action': 'getCategorySummary',
        'data' :jsonEncode({
          "filter_type": filterType.name,
          if(filterType == FilterTypeEnum.month)
            "month_key":  DateFormat('yyyy-MM').format(date)
          else
            "date" : DateFormat('yyyy-MM-dd').format(date)
        })
      };

      final response = await dioClient.get("", queryParameters: queryParameters);
      return parseOrThrow<CategoriesSummaryModel>(
        response: response,
        onSuccess: () => CategoriesSummaryModel.fromJson(response.data['data']),
      );
    } on DioException catch (error) {
      throw ServerException(error.toString(), code: error.response?.statusCode.toString());
    } catch (error) {
      throw UnknownException(error.toString());
    }
  }
}
