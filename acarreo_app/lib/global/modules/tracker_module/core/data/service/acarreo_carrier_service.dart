import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_carrier.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/filter_params.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/carrier_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/carries_service.dart';

class AcarreoCarrierService implements CarrierService<AcarreoCarrier> {
  AcarreoCarrierService({
    required this.storage,
    required this.repository,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.customers);
  }

  final LocalStorageService localStorageService;
  final CarrierRepository<AcarreoCarrier> repository;
  final StorageService storage;

  @override
  get() async {
    try {
      final items = await localStorageService.getItems();
      final carrieries =
          items.cast().map((i) => AcarreoCarrier.fromJson(i)).toList();
      return carrieries;
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

      final filterParams = FilterParams(
        idClient: currentUser.idClient,
        idProject: currentUser.idProject,
        idModule: currentUser.idModule,
      );

      final carries = await repository.getCarriesByParams(filterParams);
      final castCarries = carries.map((l) => l.toJson()).toList();
      localStorageService.saveItems(castCarries);
      return carries;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
