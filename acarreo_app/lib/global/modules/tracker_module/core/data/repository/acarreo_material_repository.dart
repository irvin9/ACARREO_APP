import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/material_repository.dart';

class AcarreoMaterialRepository extends BaseRepository<AcarreoMaterial>
    implements MaterialRepository<AcarreoMaterial> {
  AcarreoMaterialRepository();

  static const String _subCategoryPath = '/materiales/';
  @override
  getMaterialsByClientAndProject(String idClient, String idProject) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath';

    final Map<String, String> params = {
      'id_client': idClient,
      'id_project': idProject
    };
    final response = await http.request(
        url: url,
        token: TypeToken.bearerToken,
        httpMethod: HttpMethods.GET,
        params: params);
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<AcarreoMaterial>.fromJson(
        response.body, AcarreoMaterial.fromJson);
    return body.data;
  }
}
