import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_current_location/widgets/preview_location_travel.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class PreviewCurrentLocationScreen extends StatelessWidget {
  const PreviewCurrentLocationScreen({
    super.key,
    this.currentStep = 2,
  });

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<AcarreoCubit>();
    final currentUser = cubit.storage.currentUser;
    const String title = 'Verfica la ubicación';

    return GeneralTrackerWrap(
        currentStep: currentStep,
        onContinue: () {
          if (currentUser.idModule == 0) {
            Modular.to.navigate(GlobalRoutesApp.readTravelNFCRoute);
          } else {
            Modular.to.navigate(GlobalRoutesApp.detailsTicketTravelRoute);
          }
        },
        actions: [
          GeneralButton(
            vertical: 16.0,
            horizontal: 16.0,
            buttonText: 'Cambiar Ubicación',
            buttonElevation: 2.0,
            textColor: Colors.black87,
            onPressed: () {
              cubit.clearDataFirstLocation();
              Modular.to.pushNamedAndRemoveUntil(
                  GlobalRoutesApp.registerTravelRoute,
                  ModalRoute.withName('/'));
            },
          ),
        ],
        children: const [
          TitleForm(
            title: title,
          ),
          PreviewLocationTravel()
        ]);
  }
}
