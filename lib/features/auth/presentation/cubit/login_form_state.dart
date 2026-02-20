part of 'login_form_cubit.dart';

class LoginFormState extends Equatable {
  final bool isInitial;
  final Either<ValidationFailure, Email> emailResult;
  final Either<PasswordFailure, Password> passwordResult;

  const LoginFormState({
    required this.isInitial,
    required this.emailResult,
    required this.passwordResult,
  });

  factory LoginFormState.initial() => LoginFormState(
    isInitial: true,
    emailResult: Email.create(''),
    passwordResult: Password.create(''),
  );

  PasswordFailure? get passwordFailure =>
      isInitial ? null : passwordResult.fold((l) => l, (r) => null);
  String? get emailFailureMessage =>
      emailResult.fold((l) => isInitial ? null : l.message, (r) => null);

  AuthRequestEntity? get authRequestEntity {
    final entity = emailResult.fold(
      (l) => null,
      (email) => passwordResult.fold(
        (l) => null,
        (pass) => AuthRequestEntity(email: email, password: pass),
      ),
    );

    return entity;
  }

  bool get isValid => authRequestEntity != null;

  LoginFormState copyWith({
    Either<ValidationFailure, Email>? emailResult,
    Either<PasswordFailure, Password>? passwordResult,
  }) {
    return LoginFormState(
      isInitial: false,
      emailResult: emailResult ?? this.emailResult,
      passwordResult: passwordResult ?? this.passwordResult,
    );
  }

  @override
  List<Object> get props => [emailResult, passwordResult];
}
