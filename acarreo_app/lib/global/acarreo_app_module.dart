import 'package:flutter_modular/flutter_modular.dart';
import 'package:acarreo_app/global/modules/auth_module/auth_module.dart';
import 'package:acarreo_app/global/modules/home_module/core/home_module.dart';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class AcarreoAppModule extends Module {
  @override
  void binds(i) {}

  @override
  get imports => [AuthModule()];

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
