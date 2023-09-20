import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/truck_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';

class AcarreoTruckService implements TruckService<AcarreoTruck> {
  AcarreoTruckService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.trucks);
  }

  final LocalStorageService localStorageService;
  final TruckRepository<AcarreoTruck> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final trucks = items.cast().map((i) => AcarreoTruck.fromJson(i)).toList();
      return trucks;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  update() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final trucks = await repository.getTrucksByClientAndProject(
        currentUser.idClient.toString(),
        currentUser.idProject.toString(),
      );
      final castTrucks = trucks.map((i) => i.toMap()).toList();
      localStorageService.saveItems(castTrucks);
      return trucks;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
