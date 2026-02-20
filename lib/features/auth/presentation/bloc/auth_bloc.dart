import 'dart:async';

import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/auth_request_entity.dart';
import 'package:dotnet_notification_front/features/auth/domain/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthRequest>(_onAuthRequest);
  }

  FutureOr<void> _onAuthRequest(
    AuthRequest event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await repository.authenticate(event.request);

    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (success) => emit(AuthSuccess()),
    );
  }
}
