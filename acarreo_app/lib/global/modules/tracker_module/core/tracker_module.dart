import 'package:acarreo_app/global/acarreo_app_module.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/repository/scan_nfc_manager_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_location.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_material.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_location_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_material_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_ticket_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_truck_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_truck_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/nfc/nfc_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/location_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/material_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/ticket_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/truck_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/truck_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/details_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/read_nfc_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/register_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter/material.dart';

const int totalSteps = 4;

class TrackerModule extends Module {
  @override
  void binds(Injector i) {
    i.addLazySingleton<ScanNfcRepository>(ScanNFCManagerRepository.new);
    i.add<LocationRepository<AcarreoLocation>>(AcarreoLocationRepository.new);
    i.addLazySingleton<MaterialRepository<AcarreoMaterial>>(
        AcarreoMaterialRepository.new);
    i.addLazySingleton<TicketRepository<AcarreoTicket>>(
        AcarreoTicketRepository.new);
    i.addLazySingleton<TruckRepository<AcarreoTruck>>(
        AcarreoTruckRepository.new);

    i.add<LocalStorageService>(HiveLocalStorageService.new);
    i.addLazySingleton<LocationService<AcarreoLocation>>(
        AcarreoLocationService.new);
    i.addLazySingleton<MaterialService<AcarreoMaterial>>(
        AcarreoMaterialService.new);
    i.addLazySingleton<TicketService>(AcarreoTickeService.new);
    i.addLazySingleton<TruckService<AcarreoTruck>>(AcarreoTruckService.new);
    i.addLazySingleton<AcarreoDataManagerService>(
        AcarreoDataManagerService.new);
    i.addLazySingleton<AcarreoCubit>(AcarreoCubit.new);
    i.addLazySingleton<NfcCubit>(NfcCubit.new);
  }

  Future<bool> initExternalService() async {
    await HiveLocalStorageService.initStorage();
    return true;
  }

  @override
  List<Module> get imports => [AcarreoAppModule()];

  @override
  void routes(RouteManager r) {
    r.child(
      '/form',
      child: (context) => BlocProvider(
        create: (BuildContext context) => Modular.get<AcarreoCubit>(),
        child: FutureBuilder(
          future: initExternalService(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Modular.get<AcarreoCubit>().getLocalData();
            }
            return const RouterOutlet();
          },
        ),
      ),
      children: [
        ChildRoute(
          TrackerRoutesModule.registerTravelRoute,
          child: (context) => const RegisterTravelScreen(
            currentStep: 1,
            totalSteps: totalSteps,
          ),
        ),
        ChildRoute(
          TrackerRoutesModule.readTravelNFCRoute,
          child: (context) => BlocProvider.value(
            value: Modular.get<NfcCubit>()..startScan(),
            child: const ReadNFCTravelScreen(
              currentStep: 2,
              totalSteps: totalSteps,
            ),
          ),
        ),
        ChildRoute(
          TrackerRoutesModule.detailsTicketTravelRoute,
          child: (context) => const DetailsTicketTravelScreen(
            currentStep: 3,
            totalSteps: totalSteps,
          ),
        ),
        ChildRoute(
          TrackerRoutesModule.previewTicketTravelRoute,
          child: (context) => const PreviewTicketTravelScreen(
            currentStep: 4,
            totalSteps: totalSteps,
          ),
        ),
      ],
    );
  }
}
