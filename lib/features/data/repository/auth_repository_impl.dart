import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:dotnet_notification_front/core/domain/repository/base_repository.dart';
import 'package:dotnet_notification_front/core/network/server_api_client.dart';
import 'package:dotnet_notification_front/features/data/models/auth_response_model.dart';

import 'package:dotnet_notification_front/features/domain/entities/auth_request/auth_request_entity.dart';
import 'package:dotnet_notification_front/features/domain/entities/auth_response_entity.dart';
import 'package:dotnet_notification_front/features/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<Failure, AuthResponseEntity>> authenticate(
    AuthRequestEntity request,
  ) {
    return BaseRepository.remoteRequest(
      request: () => _apiClient.post('/auth', {
        'username': request.email,
        'password': request.password,
      }),
      onSuccess: (json) => AuthResponseModel.fromJson(json),
    );
  }
}
