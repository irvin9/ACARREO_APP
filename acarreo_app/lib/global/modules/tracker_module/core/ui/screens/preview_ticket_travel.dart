import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_screen.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/widgets.dart';

class PreviewTicketTravel extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  const PreviewTicketTravel({super.key, this.currentStep, this.totalSteps});

  @override
  Widget build(BuildContext context) {
    const String title = 'Identifica tu Unidad';
    const String description =
        'Leeremos su código de indentificación mediante un lector NFC.';

    return GeneralTrackerScreen(
      currentStep: currentStep,
      children: const [
        TitleForm(
          title: title,
          description: description,
        ),
      ],
    );
  }
}
