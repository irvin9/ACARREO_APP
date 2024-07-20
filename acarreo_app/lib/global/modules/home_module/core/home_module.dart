import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/binds/thermal_printer_service_factory.dart';
import 'package:acarreo_app/global/core/data/service/flutter_blue_service.dart';
import 'package:acarreo_app/global/core/domain/service/thermal_printer_service.dart';
import 'package:acarreo_app/global/modules/home_module/core/domain/cubit/home_cubit/home_cubit.dart';
import 'package:acarreo_app/global/modules/home_module/core/ui/screens/home_screen.dart';
import 'package:acarreo_app/global/modules/ticket_module/ticket_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_carrier_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_customer_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_location_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_material_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_operating_company_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_ticket_material_supplier_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_ticket_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/acarreo_truck_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/repository/api_project_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_carrier_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_customer_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_location_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_material_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_operating_company_service.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/service/acarreo_ticket_material_supplier_service.dart';
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
        Bind.lazySingleton((i) => AcarreoCustomerRepository()),
        Bind.lazySingleton((i) => AcarreoOperatingCompanyRepository()),
        Bind.lazySingleton((i) => AcarreoCarrierRepository()),
        Bind.lazySingleton((i) => AcarreoTicketMaterialSupplierRepository()),
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
        Bind.lazySingleton((i) => AcarreoCustomerService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => AcarreoOperatingCompanyService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => AcarreoCarrierService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton((i) => AcarreoTicketMaterialSupplierService(
            localStorageService: i(), repository: i(), storage: i())),
        Bind.lazySingleton(
          (i) => AcarreoDataManagerService(
            preferencesStorage: i(),
            locationService: i(),
            materialService: i(),
            projectService: i(),
            ticketService: i(),
            truckService: i(),
            customerService: i(),
            operatingCompanyService: i(),
            carrierService: i(),
            ticketMaterialSupplierService: i(),
          ),
        ),
        Bind.lazySingleton<FlutterBlueService>((i) => FlutterBlueService()),
        Bind.lazySingleton<ThermalPrinterService>(
            (i) => StartxpandThermalPrinterService(btnService: i())),
        Bind.lazySingleton((i) => HomeCubit(i())),
        Bind.lazySingleton((i) => AcarreoCubit(i())),
        Bind.lazySingleton((i) => ThermalPrinterServiceFactory()),
        Bind.lazySingleton<PrinterCubit>((i) => PrinterCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                  value: Modular.get<AcarreoCubit>()..getLocalData()),
              BlocProvider.value(
                  value: Modular.get<HomeCubit>()..getMenuItems()),
            ],
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
