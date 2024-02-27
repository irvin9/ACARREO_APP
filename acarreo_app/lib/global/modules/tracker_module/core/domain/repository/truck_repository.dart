import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';

abstract class TruckRepository<T> {
  Future<List<T>> getTrucksByClientAndProject(
      String clientId, String projectId);
  Future<T> getTruckByPlate(String plate);
  Future<List<T>> getTrucksByParams(FilterParams params);
}
