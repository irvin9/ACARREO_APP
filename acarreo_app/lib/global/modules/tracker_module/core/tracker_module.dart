import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/register_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TrackerModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(TrackerRoutesModule.registerTravelRoute,
        child: (context) => const RegisterTravelScreen());
  }
}
