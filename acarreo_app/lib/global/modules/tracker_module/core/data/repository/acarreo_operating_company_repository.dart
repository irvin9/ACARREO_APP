import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_operating_company.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/operating_company_repository.dart';

class AcarreoOperatingCompanyRepository
    extends BaseRepository<AcarreoOperatingCompany>
    implements OperatingCompanyRepository<AcarreoOperatingCompany> {
  AcarreoOperatingCompanyRepository();

  static const String _subCategoryPath = '/empresaexplotadora/';

  @override
  getOperatingCompaniesByParams(FilterParams params) async {
    final String hostUrl = environment.apiHostUrl;
    final String apiVersion = environment.apiAuthVersion;
    final String url = '$hostUrl$apiVersion$_subCategoryPath';

    final response = await http.request(
      url: url,
      token: TypeToken.bearerToken,
      httpMethod: HttpMethods.GET,
      params: params.toMap,
    );
    if (response.statusCode != HttpStatus.ok) {
      throw ApiRestException.fromResponse(response);
    }

    final body = ApiRestPaginated<AcarreoOperatingCompany>.fromJson(
        response.body, AcarreoOperatingCompany.fromJson);
    return body.data;
  }
}
