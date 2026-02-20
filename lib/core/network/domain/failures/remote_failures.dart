import '../../../domain/error/failure.dart';

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required String message}) : super(message);
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure({required String message}) : super(message);
}

class BadRequestFailure extends Failure {
  const BadRequestFailure({required String message}) : super(message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required String message}) : super(message);
}

class ServerFailure extends Failure {
  const ServerFailure({required String message}) : super(message);
}

class ConflictFailure extends Failure {
  const ConflictFailure({required String message}) : super(message);
}
