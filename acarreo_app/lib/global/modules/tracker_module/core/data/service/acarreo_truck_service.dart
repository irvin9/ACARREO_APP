import 'package:flutter/foundation.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/truck_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';

class AcarreoTruckService implements TruckService {
  final TruckRepository<AcarreoTruck> repository;
  final StorageService storage;

  AcarreoTruckService({required this.storage, required this.repository});

  @override
  getTrucks() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final trucks = await repository.getTrucksByClientAndProject(
        currentUser.idClient.toString(),
        currentUser.idProject.toString(),
      );
      return trucks;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
