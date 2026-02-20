import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final Object? data;

  const Failure(this.message, {this.data});

  @override
  List<Object?> get props => [message, data];
}

class BusinessFailure extends Failure {
  const BusinessFailure({required String message}) : super(message);
}

class OrderFailure extends Failure {
  const OrderFailure({required String message, data})
    : super(message, data: data);
}

class NetworkFailure extends Failure {
  const NetworkFailure({required String message}) : super(message);
}

class ConnectionFailure extends Failure {
  const ConnectionFailure({required String message}) : super(message);
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({required String message}) : super(message);
}

class UnknownFailure extends Failure {
  const UnknownFailure({required String message}) : super(message);
}
