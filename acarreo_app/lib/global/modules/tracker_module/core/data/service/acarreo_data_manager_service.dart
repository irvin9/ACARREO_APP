import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/data_manager_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';
import 'package:flutter/foundation.dart';

class AcarreoDataManagerService implements DataManagerService {
  final LocationService locationService;
  final MaterialService materialService;
  final TicketService ticketService;
  final TruckService truckService;

  AcarreoDataManagerService({
    required this.locationService,
    required this.materialService,
    required this.ticketService,
    required this.truckService,
  });

  @override
  Future<void> getData() async {
    try {
      final locations = await locationService.getLocations();
      final materials = await materialService.getMaterials();
      final trucks = await truckService.getTrucks();
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
    // await Future.delayed(const Duration(seconds: 3));
  }

  @override
  Future<void> uploadData() async {
    // TODO: implement uploadData
    throw UnimplementedError();
  }
}
