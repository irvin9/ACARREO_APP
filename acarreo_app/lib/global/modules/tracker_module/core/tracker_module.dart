import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/repository/scan_nfc_manager_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_location_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_material_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_ticket_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_truck_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/api_project_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_ticket_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_truck_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/api_project_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/nfc/nfc_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/printer/printer_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/list_tickets/list_tickets_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/details_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/list_tickets_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/read_nfc_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/register_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/review_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter/material.dart';

const int totalSteps = 4;

class TrackerModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => ScanNFCManagerRepository()),
        Bind.lazySingleton((i) => AcarreoLocationRepository()),
        Bind.lazySingleton((i) => AcarreoMaterialRepository()),
        Bind.lazySingleton((i) => AcarreoTruckRepository()),
        Bind.lazySingleton((i) => ApiProjectRepository()),
        Bind.lazySingleton((i) => AcarreoTicketRepository()),
        Bind.lazySingleton((i) => ScanNFCManagerRepository()),
        Bind.lazySingleton((i) => AcarreoLocationService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => AcarreoMaterialService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => AcarreoTruckService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => AcarreoTickeService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => ApiProjectService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton(
          (i) => AcarreoDataManagerService(
              locationService: i(),
              materialService: i(),
              projectService: i(),
              ticketService: i(),
              truckService: i()),
        ),
        Bind.lazySingleton((i) => StartxpandPrinterBluetoothService()),
        Bind.lazySingleton((i) => AcarreoCubit(i())),
        Bind.lazySingleton((i) => PrinterCubit(i())),
        Bind.lazySingleton((i) => NfcCubit(i(), i())),
        Bind.lazySingleton((i) => ListTicketsCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          TrackerRoutesModule.listTicketRoute,
          child: ((context, args) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: Modular.get<AcarreoCubit>()),
                  BlocProvider.value(value: Modular.get<ListTicketsCubit>()),
                  BlocProvider.value(value: Modular.get<PrinterCubit>()),
                ],
                child: const ListTicketsScreen(),
              )),
        ),
        ChildRoute(
          TrackerRoutesModule.reviewTicketRoute,
          child: ((context, args) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: Modular.get<AcarreoCubit>()),
                  BlocProvider.value(value: Modular.get<ListTicketsCubit>()),
                  BlocProvider.value(value: Modular.get<PrinterCubit>()),
                ],
                child: const ReviewTicketTravelScreen(),
              )),
        ),
        ChildRoute(
          TrackerRoutesModule.formTravelRoute,
          child: ((context, args) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(value: Modular.get<AcarreoCubit>()),
                  BlocProvider.value(value: Modular.get<PrinterCubit>()),
                ],
                child: FutureBuilder(
                  future: initExternalService(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Modular.get<AcarreoCubit>().getLocalData();
                    }
                    return const RouterOutlet();
                  },
                ),
              )),
          children: [
            ChildRoute(
              TrackerRoutesModule.registerTravelRoute,
              child: (context, args) => const RegisterTravelScreen(
                currentStep: 1,
                totalSteps: totalSteps,
              ),
            ),
            ChildRoute(
              TrackerRoutesModule.readTravelNFCRoute,
              child: (context, args) => BlocProvider.value(
                value: Modular.get<NfcCubit>()..startScan(),
                child: const ReadNFCTravelScreen(
                  currentStep: 2,
                  totalSteps: totalSteps,
                ),
              ),
            ),
            ChildRoute(
              TrackerRoutesModule.detailsTicketTravelRoute,
              child: (context, args) => const DetailsTicketTravelScreen(
                currentStep: 3,
                totalSteps: totalSteps,
              ),
            ),
            ChildRoute(
              TrackerRoutesModule.previewTicketTravelRoute,
              child: (context, args) => const PreviewTicketTravelScreen(
                currentStep: 4,
                totalSteps: totalSteps,
              ),
            ),
          ],
        ),
      ];

  Future<bool> initExternalService() async {
    await HiveLocalStorageService.initStorage();
    return true;
  }
}
