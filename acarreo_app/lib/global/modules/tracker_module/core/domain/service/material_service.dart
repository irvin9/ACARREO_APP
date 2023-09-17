import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';

abstract class MaterialService {
  Future<List<AcarreoMaterial>?> getMaterials();
}
