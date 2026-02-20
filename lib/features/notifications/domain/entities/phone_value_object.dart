import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/entities/email_failure.dart';
import '../../../../core/domain/error/failure.dart';

class PhoneNumber extends Equatable {
  final String value;

  const PhoneNumber._(this.value);

  static Either<Failure, PhoneNumber> create(String input) {
    final RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');

    if (phoneRegex.hasMatch(input)) {
      return Right(PhoneNumber._(input));
    } else {
      return Left(ValidationFailure('Invalid phone number format'));
    }
  }

  @override
  List<Object?> get props => [value];
}
