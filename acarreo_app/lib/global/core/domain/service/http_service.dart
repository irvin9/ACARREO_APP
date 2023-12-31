import 'package:acarreo_app/global/core/data/enum/http_methods.dart';
import 'package:acarreo_app/global/core/data/enum/type_token.dart';
import 'package:acarreo_app/global/core/data/model/response_http_model.dart';

abstract class HttpService {
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-Requested-With': 'XMLHttpRequest',
  };

  Map<String, String> get headers => _headers;

  Future<ResponseHttpModel> request({
    required String url,
    required HttpMethods httpMethod,
    TypeToken? token,
    Map<String, dynamic>? data,
    Map<String, String>? params,
    String? route,
  });

  Future<Map<String, String>> addTokenHeaders(TypeToken? tokenHeader);
}
