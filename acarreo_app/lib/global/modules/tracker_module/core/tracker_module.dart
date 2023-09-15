import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/details_ticket_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_ticket_travel.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/read_nfc_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/register_travel_screen.dart';
import 'package:acarreo_app/global/modules/tracker_module/tracker_module.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

const int totalSteps = 4;

class TrackerModule extends Module {
  @override
  void routes(RouteManager r) {
    debugPrint(r.args.params.toString());
    r.child(
      TrackerRoutesModule.registerTravelRoute,
      child: (context) => const RegisterTravelScreen(
        currentStep: 1,
        totalSteps: totalSteps,
      ),
    );
    r.child(
      TrackerRoutesModule.readTravelNFCRoute,
      child: (context) {
        return const ReadNFCTravelScreen(
          currentStep: 2,
          totalSteps: totalSteps,
        );
      },
    );
    r.child(
      TrackerRoutesModule.detailsTicketTravelRoute,
      child: (context) {
        return const DetailsTicketTravelScreen(
          currentStep: 3,
          totalSteps: totalSteps,
        );
      },
    );
    r.child(
      TrackerRoutesModule.previewTicketTravelRoute,
      child: (context) {
        return const PreviewTicketTravel(
          currentStep: 4,
          totalSteps: totalSteps,
        );
      },
    );
  }
}
