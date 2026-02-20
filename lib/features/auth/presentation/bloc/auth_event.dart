part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthRequest extends AuthEvent {
  final AuthRequestEntity request;

  const AuthRequest(this.request);
}
