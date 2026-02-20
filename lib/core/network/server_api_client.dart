import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'server_info.dart';

part 'response_log.dart';

class ApiClient {
  final _storage = const FlutterSecureStorage();

  /// Get the stored JWT token
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  /// Centralized headers with Authorization
  Future<Map<String, String>> _getHeaders() async {
    final token = await _getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  // health check endpoint
  Future<bool> healthCheck() async {
    try {
      final response = await get('$baseUrl/health/ping', urlOverride: true);
      return response.statusCode == 200;
    } catch (e) {
      log('Health check failed: $e');
      return false;
    }
  }

  /// GET Request
  Future<http.Response> get(
    String endpoint, {
    bool urlOverride = false,
    String? versionOverride,
  }) async {
    final url = Uri.parse(
      urlOverride
          ? endpoint
          : '$baseUrl/${versionOverride ?? apiVersion}$endpoint',
    );
    final response = await http.get(url, headers: await _getHeaders());

    if (kDebugMode) {
      log(_formatResponseLog(response), name: 'HTTP GET $endpoint');
    }
    return response;
  }

  /// POST Request
  Future<http.Response> post(
    String endpoint,
    Map<String, dynamic> body, {
    String? versionOverride,
  }) async {
    final url = Uri.parse('$baseUrl/${versionOverride ?? apiVersion}$endpoint');
    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );

    if (kDebugMode) {
      log(
        _formatResponseLog(response, requestBody: body),
        name: 'HTTP POST $endpoint',
      );
    }

    return response;
  }

  /// PUT Request
  Future<http.Response> put(
    String endpoint,
    Map<String, dynamic> body, {
    String? versionOverride,
  }) async {
    final url = Uri.parse('$baseUrl/${versionOverride ?? apiVersion}$endpoint');
    final response = await http.put(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );

    if (kDebugMode) {
      log(
        _formatResponseLog(response, requestBody: body),
        name: 'HTTP PUT $endpoint',
      );
    }
    return response;
  }

  // DELETE Request
  Future<http.Response> delete(
    String endpoint, {
    String? versionOverride,
  }) async {
    final url = Uri.parse('$baseUrl/${versionOverride ?? apiVersion}$endpoint');
    final response = await http.delete(url, headers: await _getHeaders());

    if (kDebugMode) {
      log(_formatResponseLog(response), name: 'HTTP DELETE $endpoint');
    }
    return response;
  }
}
