import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/location_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';

class AcarreoLocationService implements LocationService<AcarreoLocation> {
  AcarreoLocationService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.locations);
  }

  final LocalStorageService localStorageService;
  final LocationRepository<AcarreoLocation> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final locations =
          items.cast().map((i) => AcarreoLocation.fromJson(i)).toList();
      return locations;
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
      final locations = await repository.getLocationsByClientAndProject(
          currentUser.idClient.toString(), currentUser.idProject.toString());

      final castLocations = locations.map((l) => l.toJson()).toList();
      localStorageService.saveItems(castLocations);
      return locations;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
