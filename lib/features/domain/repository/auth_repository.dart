import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import '../entities/auth_request/auth_request_entity.dart';
import '../entities/auth_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponseEntity>> authenticate(
    AuthRequestEntity request,
  );
}
