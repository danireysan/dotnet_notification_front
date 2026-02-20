import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final Object? data;

  const Failure(this.message, {this.data});

  @override
  List<Object?> get props => [message, data];
}

class UnknownFailure extends Failure {
  const UnknownFailure({required String message}) : super(message);
}
