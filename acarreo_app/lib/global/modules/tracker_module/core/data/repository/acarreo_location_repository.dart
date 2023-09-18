import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/location_repository.dart';

class AcarreoLocationRepository extends BaseRepository
    implements LocationRepository<AcarreoLocation> {
  AcarreoLocationRepository();

  static const String _subCategoryPath = '/ubicaciones';

  @override
  getLocationsByClientAndProject(String idClient, String idProject) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath';

    final Map<String, String> params = {
      'id_client': idClient,
      'id_project': idProject
    };
    final response = await http.request(
        url: url, httpMethod: HttpMethods.GET, params: params);
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<AcarreoLocation>.fromJson(
        response.body, AcarreoLocation.fromJson);
    return body.data;
  }
}
