import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/details_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_ticket_travel.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/read_nfc_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/register_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

const int totalSteps = 4;

class TrackerModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child(
      '/form',
      child: (context) => const RouterOutlet(),
      children: [
        ChildRoute(
          TrackerRoutesModule.registerTravelRoute,
          child: (context) => const RegisterTravelScreen(
            currentStep: 1,
            totalSteps: totalSteps,
          ),
        ),
        ChildRoute(
          TrackerRoutesModule.readTravelNFCRoute,
          child: (context) => const ReadNFCTravelScreen(
            currentStep: 2,
            totalSteps: totalSteps,
          ),
        ),
        ChildRoute(
          TrackerRoutesModule.detailsTicketTravelRoute,
          child: (context) => const DetailsTicketTravelScreen(
            currentStep: 3,
            totalSteps: totalSteps,
          ),
        ),
        ChildRoute(
          TrackerRoutesModule.previewTicketTravelRoute,
          child: (context) => const PreviewTicketTravel(
            currentStep: 4,
            totalSteps: totalSteps,
          ),
        ),
      ],
    );
  }
}
