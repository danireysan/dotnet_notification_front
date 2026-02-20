part of 'login_form_cubit.dart';

class LoginFormState extends Equatable {
  final Either<EmailFailure, Email> emailResult;
  final Either<PasswordFailure, Password> passwordResult;

  const LoginFormState({
    required this.emailResult,
    required this.passwordResult,
  });

  factory LoginFormState.initial() => LoginFormState(
    emailResult: Email.create(''),
    passwordResult: Password.create(''),
  );

  PasswordFailure? get passwordFailure =>
      passwordResult.fold((l) => l, (r) => null);
  EmailFailure? get emailFailure => emailResult.fold((l) => l, (r) => null);

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
    Either<EmailFailure, Email>? emailResult,
    Either<PasswordFailure, Password>? passwordResult,
  }) {
    return LoginFormState(
      emailResult: emailResult ?? this.emailResult,
      passwordResult: passwordResult ?? this.passwordResult,
    );
  }

  @override
  List<Object> get props => [emailResult, passwordResult];
}
