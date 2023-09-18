import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/location_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';
import 'package:flutter/foundation.dart';

class AcarreoLocationService implements LocationService {
  final LocationRepository<AcarreoLocation> repository;
  final StorageService storage;

  AcarreoLocationService({required this.storage, required this.repository});

  @override
  getLocations() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final locations = await repository.getLocationsByClientAndProject(
        currentUser.idClient.toString(),
        currentUser.idProject.toString(),
      );
      return locations;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
