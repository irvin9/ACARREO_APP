import 'package:acarreo_app/global/modules/auth_module/auth_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/home_module.dart';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class AcarreoAppModule extends Module {
  @override
  get imports => [AuthModule()];

  @override
  void binds(Injector i) {
    i.addSingleton<FlutterSecureStorage>(FlutterSecureStorage.new);
    i.addSingleton<StorageService>(FlutterStorageService.new);
    i.addSingleton<EnviromentService>(FlutterEnvironmentService.new);
    i.addSingleton<HttpService>(FlutterHttpService.new);
  }

  @override
  void routes(r) {
    super.routes(r);
    r.module(
      GlobalRoutesApp.authRoute,
      module: AuthModule(),
      guards: [SessionGuard()],
    );
    r.module(
      GlobalRoutesApp.homeRoute,
      module: HomeModule(),
      guards: [AuthGuard()],
    );
  }
}
