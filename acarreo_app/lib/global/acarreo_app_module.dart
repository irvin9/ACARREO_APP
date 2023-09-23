import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/auth_module/auth_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/tracker_module.dart';

class AcarreoAppModule extends Module {
  @override
  get imports => [AuthModule()];

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => const FlutterSecureStorage()),
        Bind.singleton((i) => FlutterEnvironmentService()),
        Bind.singleton((i) => FlutterStorageService(i())),
        Bind.factory((i) => HiveLocalStorageService()),
        Bind.singleton((i) => FlutterHttpService(storage: i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          GlobalRoutesApp.authRoute,
          module: AuthModule(),
          guards: [SessionGuard()],
        ),
        ModuleRoute(
          GlobalRoutesApp.trackerRoute,
          module: TrackerModule(),
          guards: [AuthGuard()],
        ),
        RedirectRoute('/', to: GlobalRoutesApp.authLoginRoute)
      ];
}
