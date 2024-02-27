import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';

abstract class MaterialRepository<T> {
  Future<List<T>> getMaterialsByClientAndProject(
      String idClient, String idProject);
  Future<List<T>> getMaterialsByParams(FilterParams params);
}
