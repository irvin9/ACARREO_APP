import 'package:acarreo_app/global/modules/home_module/core/routes/module_routes.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomeModule extends Module {
  @override
  void routes(RouteManager r) {
    r.module(HomeRoutesModule.trackerRoute, module: TrackerModule());
  }
}
