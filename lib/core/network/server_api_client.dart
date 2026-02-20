import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final String baseUrl;
  final _storage = const FlutterSecureStorage();

  ApiClient({required this.baseUrl});

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
      final response = await get('/health/ping');
      return response.statusCode == 200;
    } catch (e) {
      log('Health check failed: $e');
      return false;
    }
  }

  /// GET Request
  Future<http.Response> get(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(url, headers: await _getHeaders());

    if (kDebugMode) {
      log(_formatResponseLog(response));
    }
    return response;
  }

  /// POST Request
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );

    if (kDebugMode) {
      log(_formatResponseLog(response, requestBody: body));
    }

    return response;
  }

  /// PUT Request
  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(
      url,
      headers: await _getHeaders(),
      body: jsonEncode(body),
    );

    if (kDebugMode) {
      log(_formatResponseLog(response, requestBody: body));
    }
    return response;
  }

  // DELETE Request
  Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(url, headers: await _getHeaders());

    if (kDebugMode) {
      log(_formatResponseLog(response));
    }
    return response;
  }

  /// Your custom logging formatter
  String _formatResponseLog(http.Response response, {Object? requestBody}) {
    final time = DateTime.now().toUtc().toIso8601String();
    const encoder = JsonEncoder.withIndent('  ');

    String formattedRequestBody =
        requestBody != null ? encoder.convert(requestBody) : '';

    String formattedBodyJson;
    try {
      final json = jsonDecode(response.body);
      formattedBodyJson = encoder.convert(json);
    } catch (_) {
      formattedBodyJson = response.body;
    }

    return '''
------------------------------------------------------------
$time
Request: ${response.request}${formattedRequestBody.isNotEmpty ? '\nRequest body: $formattedRequestBody' : ''}
Response code: ${response.statusCode}
Body: $formattedBodyJson
------------------------------------------------------------
''';
  }
}
