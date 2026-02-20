import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/auth_request_entity.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/email_failure.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/email_value_object.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/password_failure.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/password_value_object.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormState.initial());

  void emailChanged(String input) {
    final emailResult = Email.create(input);
    emit(state.copyWith(emailResult: emailResult));
  }

  void passwordChanged(String input) {
    final passwordResult = Password.create(input);
    emit(state.copyWith(passwordResult: passwordResult));
  }
}
