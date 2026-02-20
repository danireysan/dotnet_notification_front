import 'package:dotnet_notification_front/features/notifications/domain/entities/create_notification_result.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/delete_notification_result.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/result_notification_entity.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/update_notification_result.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/error/failure.dart';
import '../../../../core/domain/repository/base_repository.dart';
import '../../../../core/network/server_api_client.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repository/notification_repository.dart';
import '../models/notification_request_model.dart';
import '../models/result_notification_model.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final ApiClient _apiClient;
  static const String _endpoint = '/notifications';

  NotificationRepositoryImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<Either<Failure, List<ResultNotificationEntity>>> getAll() {
    return BaseRepository.remoteRequest(
      request: () => _apiClient.get(_endpoint),
      onSuccess: (json) {
        final notifications = ResultNotificationModel.fromJsonList(
          json as List<dynamic>,
        );
        return notifications;
      },
    );
  }

  @override
  Future<Either<Failure, CreateNotificationResult>> create(
    NotificationEntity entity,
  ) {
    return BaseRepository.remoteRequest(
      request: () => _apiClient.post(
        _endpoint,
        NotificationRequestModel.fromEntity(entity).toJson(),
      ),
      onSuccess: (json) => CreateNotificationResult(),
    );
  }

  @override
  Future<Either<Failure, UpdateNotificationResult>> update(
    NotificationEntity entity,
  ) {
    // Assuming the ID is required for the URL path in .NET PUT requests
    return BaseRepository.remoteRequest(
      request: () => _apiClient.put(
        _endpoint,
        NotificationRequestModel.fromEntity(entity).toJson(),
      ),
      onSuccess: (json) => UpdateNotificationResult(),
    );
  }

  @override
  Future<Either<Failure, DeleteNotificationResult>> delete(String id) {
    return BaseRepository.remoteRequest(
      request: () => _apiClient.delete('$_endpoint/$id'),
      onSuccess: (_) => DeleteNotificationResult(),
    );
  }
}
