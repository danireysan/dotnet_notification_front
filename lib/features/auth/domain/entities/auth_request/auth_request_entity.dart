import 'package:dotnet_notification_front/core/domain/entities/email_value_object.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/password_value_object.dart';

class AuthRequestEntity {
  final Email email;
  final Password password;

  AuthRequestEntity({required this.email, required this.password});
}
