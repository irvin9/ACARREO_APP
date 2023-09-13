import 'package:acarreo_app/global/core/data/model/response_http_model.dart';

class ApiRestException implements Exception {
  final String message;
  final int httpStatusCode;

  const ApiRestException._(
    this.message, {
    required this.httpStatusCode,
  });

  factory ApiRestException.fromResponse(ResponseHttpModel response) =>
      ApiRestException._(response.body, httpStatusCode: response.statusCode);

  factory ApiRestException.fromMessage(String message) =>
      ApiRestException._(message, httpStatusCode: 400);

  @override
  String toString() {
    return '${runtimeType.toString()} -> {response=$message, httpStatusCode=$httpStatusCode}';
  }
}
