import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';

abstract class CarrierRepository<T> {
  Future<List<T>> getCarriesByParams(FilterParams params);
}
