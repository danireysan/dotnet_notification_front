import 'dart:async';

import 'package:dotnet_notification_front/core/domain/error/exception.dart';
import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:fpdart/fpdart.dart';

class BaseRepository<T> {
  /// Generic function that handles exceptions in the repository layer
  /// [call] is the function that will be executed in which the
  /// handle exceptions
  Future<Either<Failure, T>> remoteRequest({
    required FutureOr<Either<Failure, T>> Function() call,
  }) async {
    try {
      return await call();
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ConnectionException catch (e) {
      return Left(ConnectionFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on HttpException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
