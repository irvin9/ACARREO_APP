import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/screens/preview_current_location/widgets/preview_location_travel.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/diloag_warning.dart';
import 'package:acarreo_app/global/modules/widgets_module/general_button.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class PreviewCurrentLocationScreen extends StatelessWidget {
  const PreviewCurrentLocationScreen({
    super.key,
    this.currentStep = 2,
    this.totalSteps = 5,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    final cubit = Modular.get<AcarreoCubit>();
    const String title = 'Verfica la ubicación';

    return GeneralTrackerWrap(
        currentStep: currentStep,
        onContinue: () =>
            Modular.to.navigate(GlobalRoutesApp.readTravelNFCRoute),
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
