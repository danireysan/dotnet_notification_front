import 'package:dotnet_notification_front/features/notifications/domain/entities/create_notification_result.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/delete_notification_result.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/result_notification_entity.dart';
import 'package:dotnet_notification_front/features/notifications/domain/entities/update_notification_result.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/domain/error/failure.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<ResultNotificationEntity>>> getAll();

  Future<Either<Failure, CreateNotificationResult>> create(
    NotificationEntity entity,
  );

  Future<Either<Failure, UpdateNotificationResult>> update(
    NotificationEntity entity,
  );

  Future<Either<Failure, DeleteNotificationResult>> delete(String id);
}
