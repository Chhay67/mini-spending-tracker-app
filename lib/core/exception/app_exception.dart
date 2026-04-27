
abstract class AppException implements Exception {
  const AppException(this.message, {this.code});
  final String message;
  final String? code;

  @override
  String toString() => 'AppException(code: $code, message: $message)';
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