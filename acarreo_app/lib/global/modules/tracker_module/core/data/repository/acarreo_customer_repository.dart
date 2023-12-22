import 'dart:io';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_customer.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/customer_repository.dart';

class AcarreoCustomerRepository extends BaseRepository<AcarreoCustomer>
    implements CustomerRepository<AcarreoCustomer> {
  AcarreoCustomerRepository();

  static const String _subCategoryPath = '/customer/';

  @override
  getCustomersByParams(FilterParams params) async {
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

    final body = ApiRestPaginated<AcarreoCustomer>.fromJson(
        response.body, AcarreoCustomer.fromJson);
    return body.data;
  }
}
