import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/auth_request_entity.dart';

class AuthRequestModel extends AuthRequestEntity {
  AuthRequestModel({required super.email, required super.password});

  // from entity
  AuthRequestModel.fromEntity(AuthRequestEntity entity)
    : super(email: entity.email, password: entity.password);

  Map<String, dynamic> toJson() {
    return {'username': email.value, 'password': password.value};
  }
}
