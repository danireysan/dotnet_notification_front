import 'dart:async';

import 'package:dotnet_notification_front/core/domain/error/failure.dart';
import 'package:fpdart/fpdart.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../error/failure_mapper.dart'; // Assuming you are using dartz for Either

class BaseRepository {
  static Future<Either<Failure, T>> remoteRequest<T>({
    required Future<http.Response> Function() request,
    required T Function(dynamic json) onSuccess,
  }) async {
    try {
      final response = await request();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final decoded = jsonDecode(response.body);
        return Right(onSuccess(decoded));
      }

      final message = _extractErrorMessage(response.body);

      return Left(
        mapStatusCodeToFailure(response.statusCode, message: message),
      );
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  static String? _extractErrorMessage(String body) {
    try {
      final decoded = jsonDecode(body);
      return decoded['error'] as String?;
    } catch (_) {
      return null;
    }
  }
}
