import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/truck_repository.dart';

class AcarreoTruckRepository extends BaseRepository
    implements TruckRepository<AcarreoTruck> {
  AcarreoTruckRepository();

  static const String _subCategoryPath = '/camiones';

  @override
  Future<AcarreoTruck> getTruckByPlate(String plate) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath';

    final Map<String, String> params = {'plate': plate};
    final response = await http.request(
        url: url, httpMethod: HttpMethods.GET, params: params);
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<AcarreoTruck>.fromJson(
        response.body, AcarreoTruck.fromJson);
    return body.data.first;
  }

  @override
  Future<List<AcarreoTruck>> getTrucksByClientAndProject(
      String idClient, String idProject) async {
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
      params: params,
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<AcarreoTruck>.fromJson(
        response.body, AcarreoTruck.fromJson);
    return body.data;
  }
}
