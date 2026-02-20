import 'package:equatable/equatable.dart';

import 'package:fpdart/fpdart.dart';

import 'password_failure.dart';

class Password extends Equatable {
  final String value;

  const Password._(this.value);

  static Either<PasswordFailure, Password> create(String input) {
    final hasLowercase = RegExp(r'[a-z]').hasMatch(input);
    final hasUppercase = RegExp(r'[A-Z]').hasMatch(input);
    final hasDigits = RegExp(r'[0-9]').hasMatch(input);
    final hasSpecial = RegExp(
      r'[!@#$%^&*()_+\-=\[\]{};:"\\|,.<>/?]',
    ).hasMatch(input);

    // Calculate how many of the 4 conditions are met
    final conditions = [hasLowercase, hasUppercase, hasDigits, hasSpecial];
    final metCount = conditions.where((element) => element).length;

    if (metCount == 4) {
      return Right(Password._(input));
    } else {
      return Left(
        PasswordFailure(
          message:
              'Password must meet at least 3 of the 4 security requirements.',
          hasLowercase: hasLowercase,
          hasUppercase: hasUppercase,
          hasDigits: hasDigits,
          hasSpecial: hasSpecial,
          metCount: metCount,
        ),
      );
    }
  }

  @override
  List<Object?> get props => [value];

  @override
  String toString() => '********'; // Security: don't log the actual password
}
