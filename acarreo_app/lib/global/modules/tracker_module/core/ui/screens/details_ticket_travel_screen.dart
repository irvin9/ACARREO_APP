import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/details_ticket_form.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class DetailsTicketTravelScreen extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  const DetailsTicketTravelScreen({
    super.key,
    this.currentStep,
    this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    const String title = 'Detalles de la Ubicación';
    // const String description =
    //     'Debes registrar los detalles de la ubicación, que se definen a continuación.';

    return GeneralTrackerWrap(
      currentStep: currentStep,
      onContinue: () {
        if (formKey.currentState!.validate()) {
          Modular.to.navigate(GlobalRoutesApp.previewTicketTravelRoute);
        }
      },
      disableToBack: true,
      children: [
        const TitleForm(
          title: title,
        ),
        const SizedBox(height: 12.0),
        DetailsTicketForm(formKey: formKey)
      ],
    );
  }
}
