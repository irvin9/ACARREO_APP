import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/api_project_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/project_repository.dart';

class ApiProjectRepository extends BaseRepository<ApiProjectModel>
    implements ProjectRepository<ApiProjectModel> {
  ApiProjectRepository();

  static const String _subCategoryPath = '/obras/';

  @override
  Future<ApiProjectModel> getById(String id) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath';

    final Map<String, String> params = {'project_code': id};

    final response = await http.request(
      url: url,
      params: params,
      token: TypeToken.bearerToken,
      httpMethod: HttpMethods.GET,
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<ApiProjectModel>.fromJson(
        response.body, ApiProjectModel.fromMap);
    return body.data.first;
  }

  @override
  Future<List<ApiProjectModel>> getProjectsByClient(String idClient) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath';

    final Map<String, String> params = {'id_client': idClient};
    final response = await http.request(
      url: url,
      token: TypeToken.bearerToken,
      httpMethod: HttpMethods.GET,
      params: params,
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<ApiProjectModel>.fromJson(
        response.body, ApiProjectModel.fromJson);
    return body.data;
  }
}
