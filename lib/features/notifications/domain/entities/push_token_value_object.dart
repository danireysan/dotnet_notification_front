import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/entities/email_failure.dart';

class PushTokenValueObject extends Equatable {
  final String value;

  const PushTokenValueObject._(this.value);

  static Either<Failure, PushTokenValueObject> create(String input) {
    if (input.trim().isEmpty) {
      return Left(ValidationFailure('Push token cannot be empty'));
    }
    return Right(PushTokenValueObject._(input));
  }

  @override
  List<Object?> get props => throw UnimplementedError();
}
