import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';

abstract class OperatingCompanyRepository<T> {
  Future<List<T>> getOperatingCompaniesByParams(FilterParams params);
}
