import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';

abstract class LocationRepository<T> {
  Future<List<T>> getLocationsByClientAndProject(
      String idClient, String idProject);

  Future<List<T>> getLocationsByParams(FilterParams params);
}
