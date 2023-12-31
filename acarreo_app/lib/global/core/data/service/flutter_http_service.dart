import 'dart:convert';
import 'package:acarreo_app/global/core/domain/service/storage_service.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:acarreo_app/global/core/utils/api_interceptor.dart';
import 'package:acarreo_app/global/core/data/enum/type_token.dart';
import 'package:acarreo_app/global/core/utils/api_retry_police.dart';
import 'package:acarreo_app/global/core/data/enum/http_methods.dart';
import 'package:acarreo_app/global/core/domain/service/http_service.dart';
import 'package:acarreo_app/global/core/data/model/api_rest_exception.dart';
import 'package:acarreo_app/global/core/data/model/response_http_model.dart';

class FlutterHttpService extends HttpService {
  FlutterHttpService({required this.storage});

  final StorageService storage;

  final Client client = InterceptedClient.build(
    interceptors: [ApiInterceptor()],
    retryPolicy: ApiRetryPolicy(),
    requestTimeout: const Duration(seconds: 30),
  );

  @override
  Future<Map<String, String>> addTokenHeaders(TypeToken? tokenHeader) async {
    String token = await storage.getToken();
    final Map<String, String> headers = {};
    if (token.isEmpty) {
      throw ApiRestException.fromMessage('Token Not Found');
    }

    switch (tokenHeader) {
      case TypeToken.bearerToken:
        headers.addAll({'Authorization': 'Bearer $token'});
      default:
        throw ApiRestException.fromMessage('El token no es soportado');
    }
    return headers;
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
    final Map<String, String> headerRequest = {...headers};
    try {
      Uri uri = Uri.parse(url);

      if (params != null) {
        uri = Uri.parse(url).replace(queryParameters: params);
      }

      if (token != null) {
        final headerToken = await addTokenHeaders(token);
        headerRequest.addAll(headerToken);
      }

      final body = jsonEncode(data);
      Response response;
      switch (httpMethod.verb) {
        case 'POST':
          response = await client.post(uri, headers: headerRequest, body: body);
          break;
        case 'GET':
          response = await client.get(uri, headers: headerRequest);
          break;
        case 'PUT':
          response = await client.put(uri, headers: headerRequest, body: body);
          break;

        case 'DELETE':
          response =
              await client.delete(uri, headers: headerRequest, body: body);
          break;

        case 'PATCH':
          response =
              await client.patch(uri, headers: headerRequest, body: body);
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
