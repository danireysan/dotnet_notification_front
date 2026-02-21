import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/device_token_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract class DeviceTokenRepository {
  Future<Either<Failure, Unit>> saveDeviceToken(String token);
  Future<Either<Failure, DeviceTokenEntity>> getDeviceToken();
}
