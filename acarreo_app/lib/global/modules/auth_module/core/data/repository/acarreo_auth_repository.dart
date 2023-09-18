import 'dart:io';
import 'dart:convert';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/enum/type_token.dart';
import 'package:acarreo_app/global/core/data/model/user_auth_model.dart';
import 'package:acarreo_app/global/modules/auth_module/core/domain/repository/auth_repository.dart';

class AcarreoAuthRepository extends BaseRepository implements AuthRepository {
  AcarreoAuthRepository();

  static const String _subCategoryPath = '/auth';

  @override
  Future getCurrentUser(int id) async {
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> login(Map<String, dynamic> credential) async {
    final String hostUrl = environment.apiAuthUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath/login';

    final Map<String, dynamic> data = credential;
    final response = await http.request(
      url: url,
      httpMethod: HttpMethods.POST,
      data: data,
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }
    final body = response.body;
    return jsonDecode(body);
  }

  @override
  Future<void> logout() async {
    final String hostUrl = environment.apiAuthUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath/logout';

    final response =
        await http.request(url: url, httpMethod: HttpMethods.DELETE);
    if (response.statusCode != HttpStatus.noContent) {
      throw ApiRestException.fromResponse(response);
    }
  }

  @override
  Future<UserAuthModel> verifyToken(String token) async {
    final String hostUrl = environment.apiAuthUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath/verify-token';

    final response = await http.request(
        url: url, token: TypeToken.bearerToken, httpMethod: HttpMethods.GET);
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }
    return UserAuthModel.fromApiJson(response.body);
  }
}
