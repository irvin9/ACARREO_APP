import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/data_manager_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';
import 'package:flutter/foundation.dart';

class AcarreoDataManagerService implements DataManagerService {
  final LocationService<AcarreoLocation> locationService;
  final MaterialService<AcarreoMaterial> materialService;
  final TicketService ticketService;
  final TruckService<AcarreoTruck> truckService;

  final List<AcarreoLocation> _localLocations = [];
  final List<AcarreoMaterial> _localMaterials = [];
  final List<AcarreoTruck> _localTrucks = [];

  List<AcarreoLocation> get locations => _localLocations;

  List<AcarreoMaterial> get materials => _localMaterials;

  List<AcarreoTruck> get trucks => _localTrucks;

  AcarreoDataManagerService({
    required this.locationService,
    required this.materialService,
    required this.ticketService,
    required this.truckService,
  });

  @override
  Future<bool> update() async {
    try {
      await locationService.update();
      await materialService.update();
      await truckService.update();
      if (!(await get())) throw Exception();
      return true;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  @override
  get() async {
    _localLocations.clear();
    _localMaterials.clear();
    _localTrucks.clear();
    final locations = await locationService.get() ?? [];
    final materials = await materialService.get() ?? [];
    final trucks = await truckService.get() ?? [];
    _localLocations.addAll(locations);
    _localMaterials.addAll(materials);
    _localTrucks.addAll(trucks);
    return _localLocations.isNotEmpty &&
        _localMaterials.isNotEmpty &&
        _localTrucks.isNotEmpty;
  }
}
