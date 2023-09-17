import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';

abstract class TruckService {
  Future<List<AcarreoTruck>?> getTrucks();
}
