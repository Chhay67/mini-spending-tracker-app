
import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  const AppException(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() => message;
}



class ServerException extends AppException {
  const ServerException(super.message, {super.code});
}


class CacheException extends AppException {
  const CacheException(super.message, {super.code});
}

class UnknownException extends AppException {
  const UnknownException(super.message, {super.code});
}

T parseOrThrow<T>({required Response response,
  required T Function() onSuccess,
}) {

  final isSuccess = response.data['success'] ?? false;
  if (isSuccess) {
    return onSuccess.call();
  }
  final errorMessage = response.data['message'] ?? 'Unknown error';
  return throw ServerException(errorMessage, code: response.statusCode?.toString());
}