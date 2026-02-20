class NetworkException implements Exception {}

// This class is to capture the server events  that return Exception
class ServerException implements Exception {
  final String? title;
  final String message;

  ServerException({this.title, required this.message}) : super();
}

class ConnectionException implements Exception {
  final String message;

  ConnectionException({required this.message}) : super();
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({required this.message}) : super();
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message}) : super();
}

class FetchDataException implements Exception {
  final String message;

  FetchDataException({required this.message}) : super();
}

class HttpException implements Exception {
  final String message;

  HttpException({required this.message}) : super();
}

class DataNotFoundException implements Exception {
  final String message;

  const DataNotFoundException({required this.message});
}
