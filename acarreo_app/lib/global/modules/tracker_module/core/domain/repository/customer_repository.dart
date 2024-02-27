import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';

abstract class CustomerRepository<T> {
  Future<List<T>> getCustomersByParams(FilterParams params);
}
