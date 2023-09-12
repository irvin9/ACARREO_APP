import 'package:acarreo_app/global/modules/auth_module/auth_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AcarreoAppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module('/auth', module: AuthModule());
  }
}
