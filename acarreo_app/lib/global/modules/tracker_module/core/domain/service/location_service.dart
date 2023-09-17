import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';

abstract class LocationService {
  Future<List<AcarreoLocation>?> getMaterials();
}
