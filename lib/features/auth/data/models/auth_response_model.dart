import 'package:dotnet_notification_front/features/auth/domain/entities/auth_response_entity.dart';

class AuthResponseModel extends AuthResponseEntity {
  AuthResponseModel({required super.token});
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(token: json['token']);
  }
}
