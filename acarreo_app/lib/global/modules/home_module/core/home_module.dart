import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/ui/screens/home_screen.dart';
import 'package:acarreo_app/global/modules/ticket_module/ticket_module.dart';
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
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => AcarreoLocationRepository()),
        Bind.lazySingleton((i) => AcarreoMaterialRepository()),
        Bind.lazySingleton((i) => AcarreoTruckRepository()),
        Bind.lazySingleton((i) => ApiProjectRepository()),
        Bind.lazySingleton((i) => AcarreoTicketRepository()),
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
              preferencesStorage: i(),
              locationService: i(),
              materialService: i(),
              projectService: i(),
              ticketService: i(),
              truckService: i()),
        ),
        Bind.lazySingleton((i) => StartxpandPrinterBluetoothService()),
        Bind.lazySingleton((i) => AcarreoCubit(i())),
        Bind.lazySingleton((i) => PrinterCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => BlocProvider.value(
            value: Modular.get<AcarreoCubit>(),
            child: const HomeScreen(),
          ),
        ),
        ModuleRoute(
          TrackerRoutesModule.trackerRoute,
          module: TrackerModule(),
        ),
        ModuleRoute(
          TicketRoutesModule.ticketsRoutes,
          module: TicketsModule(),
        ),
      ];
}
