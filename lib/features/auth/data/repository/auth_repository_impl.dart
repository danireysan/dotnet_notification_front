import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:dotnet_notification_front/core/domain/repository/base_repository.dart';
import 'package:dotnet_notification_front/core/network/server_api_client.dart';
import 'package:dotnet_notification_front/features/auth/data/models/auth_request_model.dart';
import 'package:dotnet_notification_front/features/auth/data/models/auth_response_model.dart';

import 'package:dotnet_notification_front/features/auth/domain/entities/auth_request/auth_request_entity.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/auth_response_entity.dart';
import 'package:dotnet_notification_front/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiClient _apiClient;

  AuthRepositoryImpl({required ApiClient apiClient}) : _apiClient = apiClient;

  @override
  Future<Either<Failure, AuthResponseEntity>> authenticate(
    AuthRequestEntity request,
  ) {
    return BaseRepository.remoteRequest(
      request: () => _apiClient.post(
        '/auth',
        AuthRequestModel.fromEntity(request).toJson(),
      ),
      onSuccess: (json) {
        final model = AuthResponseModel.fromJson(json);

        _apiClient.saveToken(model.token);
        return model;
      },
    );
  }
}
