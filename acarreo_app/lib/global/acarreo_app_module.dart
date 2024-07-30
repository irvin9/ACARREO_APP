import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/data/service/flutter_blue_service.dart';
import 'package:acarreo_app/global/modules/auth_module/auth_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/home_module.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AcarreoAppModule extends Module {
  @override
  get imports => [AuthModule()];

  @override
  List<Bind<Object>> get binds => [
        Bind.singleton((i) => const FlutterSecureStorage()),
        Bind.singleton((i) => FlutterEnvironmentService()),
        Bind.singleton((i) => FlutterStorageService(i())),
        Bind.factory((i) => HiveLocalStorageService()),
        AsyncBind<PackageInfo>((i) => PackageInfo.fromPlatform()),
        Bind.singleton<FlutterBlueService>((i) => FlutterBlueService()),
        Bind.singleton((i) => FlutterHttpService(storage: i())),
        Bind.lazySingleton((i) => AppPreferencesStorage(localStorage: i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          GlobalRoutesApp.authRoute,
          module: AuthModule(),
          guards: [SessionGuard()],
        ),
        ModuleRoute(
          GlobalRoutesApp.homeRoute,
          module: HomeModule(),
          guards: [AuthGuard()],
        ),
        RedirectRoute('/', to: GlobalRoutesApp.authLoginRoute)
      ];
}
