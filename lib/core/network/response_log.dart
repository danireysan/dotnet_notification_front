part of 'server_api_client.dart';

String _formatResponseLog(http.Response response, {Object? requestBody}) {
  final time = DateTime.now().toUtc().toIso8601String();
  const encoder = JsonEncoder.withIndent('  ');

  String formattedRequestBody = requestBody != null
      ? encoder.convert(requestBody)
      : '';

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
