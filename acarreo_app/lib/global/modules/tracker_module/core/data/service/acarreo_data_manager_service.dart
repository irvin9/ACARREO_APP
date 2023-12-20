import 'package:acarreo_app/global/core/data/service/preferences_app_storage.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_carrier.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_customer.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_operating_company.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket_material_supplier.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/api_project_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/carries_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/customer_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/data_manager_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/operating_company_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/project_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/foundation.dart';

class AcarreoDataManagerService implements DataManagerService {
  final AppPreferencesStorage preferencesStorage;
  final LocationService<AcarreoLocation> locationService;
  final MaterialService<AcarreoMaterial> materialService;
  final TicketService<AcarreoTicket> ticketService;
  final TruckService<AcarreoTruck> truckService;
  final ProjectService<ApiProjectModel> projectService;
  final CustomerService<AcarreoCustomer> customerService;
  final OperatingCompanyService<AcarreoOperatingCompany>
      operatingCompanyService;
  final CarrierService<AcarreoCarrier> carrierService;
  final TicketService<AcarreoTicketMaterialSupplier>
      ticketMaterialSupplierService;

  final List<AcarreoLocation> _localLocations = [];
  final List<AcarreoMaterial> _localMaterials = [];
  final List<AcarreoTruck> _localTrucks = [];
  final List<AcarreoCustomer> _localCustomers = [];
  final List<AcarreoOperatingCompany> _localCompanies = [];
  final List<AcarreoCarrier> _localCarries = [];

  ApiProjectModel? _localProject;

  List<AcarreoLocation> get locations => _localLocations;

  List<AcarreoMaterial> get materials => _localMaterials;

  List<AcarreoTruck> get trucks => _localTrucks;

  List<AcarreoCustomer> get customers => _localCustomers;

  List<AcarreoOperatingCompany> get companies => _localCompanies;

  List<AcarreoCarrier> get carries => _localCarries;

  ApiProjectModel? get project => _localProject;

  AcarreoDataManagerService(
      {required this.locationService,
      required this.materialService,
      required this.ticketService,
      required this.truckService,
      required this.projectService,
      required this.preferencesStorage,
      required this.customerService,
      required this.operatingCompanyService,
      required this.carrierService,
      required this.ticketMaterialSupplierService});

  @override
  Future<bool> update() async {
    try {
      await locationService.update();
      await materialService.update();
      await truckService.update();
      await projectService.updateProject();
      await customerService.update();
      await operatingCompanyService.update();
      await carrierService.update();
      if (!(await get())) throw Exception('There are empty value or null!');
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
    final customers = await customerService.get() ?? [];
    final companies = await operatingCompanyService.get() ?? [];
    final carries = await carrierService.get() ?? [];
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
    _localCustomers.addAll(customers);
    _localCompanies.addAll(companies);
    _localCarries.addAll(carries);
    _localProject = project;
    return true;
  }

  @override
  Future<bool> hasPeddingTickes() async {
    final tickets = await ticketService.get();
    final ticketsSupplier = await ticketMaterialSupplierService.get();

    if ((tickets == null || tickets.isEmpty) &&
        (ticketsSupplier == null || ticketsSupplier.isEmpty)) {
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
