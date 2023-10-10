import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/api_project_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/data_manager_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/project_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/foundation.dart';

class AcarreoDataManagerService implements DataManagerService {
  final LocationService<AcarreoLocation> locationService;
  final MaterialService<AcarreoMaterial> materialService;
  final TicketService<AcarreoTicket> ticketService;
  final TruckService<AcarreoTruck> truckService;
  final ProjectService<ApiProjectModel> projectService;

  final List<AcarreoLocation> _localLocations = [];
  final List<AcarreoMaterial> _localMaterials = [];
  final List<AcarreoTruck> _localTrucks = [];

  ApiProjectModel? _localProject;

  List<AcarreoLocation> get locations => _localLocations;

  List<AcarreoMaterial> get materials => _localMaterials;

  List<AcarreoTruck> get trucks => _localTrucks;

  ApiProjectModel? get project => _localProject;

  AcarreoDataManagerService({
    required this.locationService,
    required this.materialService,
    required this.ticketService,
    required this.truckService,
    required this.projectService,
  });

  @override
  Future<bool> update() async {
    try {
      await locationService.update();
      await materialService.update();
      await truckService.update();
      await projectService.updateProject();
      if (!(await get())) throw Exception('User data error!');
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
    final locations = await locationService.get() ?? [];
    final materials = await materialService.get() ?? [];
    final trucks = await truckService.get() ?? [];
    final project = await projectService.getProject();

    if (locations.isEmpty ||
        materials.isEmpty ||
        trucks.isEmpty ||
        project == null) {
      return false;
    }
    _localLocations.clear();
    _localMaterials.clear();
    _localTrucks.clear();
    _localLocations.addAll(locations);
    _localMaterials.addAll(materials);
    _localTrucks.addAll(trucks);
    _localProject = project;
    return true;
  }

  @override
  Future<bool> hasPeddingTickes() async {
    final tickets = await ticketService.get();

    if (tickets == null || tickets.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Future<String?> readScanner() async {
    try {
      final result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        if (result.format == BarcodeFormat.code128) {
          return result.rawContent;
        }
      }
      return '';
    } catch (e) {
      return null;
    }
  }
}
