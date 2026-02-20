import 'package:dotnet_notification_front/core/domain/entities/email_failure.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

class Email extends Equatable {
  final String value;

  // Private constructor
  const Email._(this.value);

  /// Factory for validation
  static Either<ValidationFailure, Email> create(String input) {
    if (_isValid(input)) {
      return Right(Email._(input));
    }
    return Left(ValidationFailure('Invalid email address'));
  }

  static bool _isValid(String input) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(input);
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => value;
}
