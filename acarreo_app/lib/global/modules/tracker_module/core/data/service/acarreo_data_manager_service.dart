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
  Future<void> update() async {
    try {
      final locations = await locationService.update();
      final materials = await materialService.update();
      final trucks = await truckService.update();
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
    }
  }

  @override
  Future<void> get() {
    // TODO: implement get
    throw UnimplementedError();
  }
}
