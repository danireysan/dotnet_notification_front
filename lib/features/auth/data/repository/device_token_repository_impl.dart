import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:dotnet_notification_front/features/auth/domain/entities/device_token_entity.dart';
import 'package:dotnet_notification_front/features/auth/domain/repository/device_token_repository.dart';
import 'package:fpdart/fpdart.dart';

class DeviceTokenRepositoryImpl implements DeviceTokenRepository {
  @override
  Future<Either<Failure, DeviceTokenEntity>> getDeviceToken() {
    // TODO: implement getDeviceToken
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> saveDeviceToken(String token) {
    // TODO: implement saveDeviceToken
    throw UnimplementedError();
  }
}
