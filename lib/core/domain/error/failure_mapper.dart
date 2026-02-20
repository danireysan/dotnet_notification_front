import 'package:dotnet_notification_front/core/domain/error/failure.dart';

import '../../network/domain/failures/remote_failures.dart';

Failure mapStatusCodeToFailure(int statusCode, {String? message}) {
  switch (statusCode) {
    case 400:
      return BadRequestFailure(message: message ?? 'Bad request');
    case 401:
      return AuthenticationFailure(message: message ?? 'Unauthorized');
    case 403:
      return AuthorizationFailure(message: message ?? 'Forbidden');
    case 404:
      return NotFoundFailure(message: message ?? 'Not found');
    case 409:
      return ConflictFailure(message: message ?? 'Conflict occurred');
    case 500:
      return ServerFailure(message: message ?? 'Internal server error');
    default:
      return UnknownFailure(message: message ?? 'An unknown error occurred');
  }
}
