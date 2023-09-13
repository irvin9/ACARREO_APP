import 'dart:convert';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:acarreo_app/global/core/utils/api_interceptor.dart';
import 'package:acarreo_app/global/core/data/enum/type_token.dart';
import 'package:acarreo_app/global/core/utils/api_retry_police.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:acarreo_app/global/core/data/enum/http_methods.dart';
import 'package:acarreo_app/global/core/domain/service/http_service.dart';
import 'package:acarreo_app/global/core/data/model/api_rest_exception.dart';
import 'package:acarreo_app/global/core/data/model/response_http_model.dart';

class HttpFlutterService extends HttpService {
  HttpFlutterService({required this.secureStorage});

  final FlutterSecureStorage secureStorage;

  final Client client = InterceptedClient.build(
    interceptors: [ApiInterceptor()],
    retryPolicy: ApiRetryPolicy(),
    requestTimeout: const Duration(seconds: 30),
  );

  @override
  Future<void> addTokenHeaders(TypeToken? tokenHeader) async {
    String token = await secureStorage.read(key: 'token') ?? '';
    if (token.isEmpty) {
      throw ApiRestException.fromMessage('Token Not Found');
    }

    switch (tokenHeader) {
      case TypeToken.bearerToken:
        headers.addAll({'Authorization': 'Bearer $token'});
        break;
      default:
        throw ApiRestException.fromMessage('El token no es soportado');
    }
  }

  @override
  Future<ResponseHttpModel> request({
    required String url,
    required HttpMethods httpMethod,
    TypeToken? token,
    Map<String, dynamic>? data,
    Map<String, String>? params,
    String? route,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      if (params != null) {
        uri = Uri.parse(url).replace(queryParameters: params);
      }

      if (token != null && TypeToken.bearerToken == token) {}

      final body = jsonEncode(data);
      Response response;
      switch (httpMethod.verb) {
        case 'POST':
          response = await client.post(uri, headers: headers, body: body);
          break;
        case 'GET':
          response = await client.get(uri, headers: headers);
          break;
        case 'PUT':
          response = await client.put(uri, headers: headers, body: body);
          break;

        case 'DELETE':
          response = await client.delete(uri, headers: headers, body: body);
          break;

        case 'PATCH':
          response = await client.patch(uri, headers: headers, body: body);
          break;
        default:
          throw ApiRestException.fromMessage(
              'No se pudo procesar tu solicitud');
      }
      return ResponseHttpModel.fromHttpFlutter(response);
    } catch (e) {
      final exception = ResponseHttpModel(body: e.toString(), statusCode: 500);
      throw ApiRestException.fromResponse(exception);
    }
  }
}
