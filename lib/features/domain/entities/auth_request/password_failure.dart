import '../../../../core/domain/error/failure.dart';

class PasswordFailure extends Failure {
  final bool hasLowercase;
  final bool hasUppercase;
  final bool hasDigits;
  final bool hasSpecial;
  final int metCount;

  const PasswordFailure({
    required String message,
    required this.hasLowercase,
    required this.hasUppercase,
    required this.hasDigits,
    required this.hasSpecial,
    required this.metCount,
  }) : super(message);

  @override
  List<Object?> get props => [
    message,
    hasLowercase,
    hasUppercase,
    hasDigits,
    hasSpecial,
    metCount,
  ];
}
