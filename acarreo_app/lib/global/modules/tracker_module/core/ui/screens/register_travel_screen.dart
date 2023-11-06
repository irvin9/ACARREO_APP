import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/nfc/nfc_cubit.dart'; //TODO: Verify this
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/register_travel_form.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class RegisterTravelScreen extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const RegisterTravelScreen({
    super.key,
    this.currentStep = 1,
    this.totalSteps = 4,
  });

  @override
  Widget build(BuildContext context) {
    Modular.get<NfcCubit>().beginScan(); //TODO: Verify this
    final formKey = GlobalKey<FormState>();
    const String title = 'Registrar Ubicación';
    const String description = 'Registra la información del la ubicación, le tomará unos minutos. '
        'Necesitamos almacenar el tipo de ubicación.';

    const String titleH2 = 'Detalles de la ubicación';
    const String descriptionH2 = 'Añade los detalles de tu ubicación';

    return GeneralTrackerWrap(
        currentStep: currentStep,
        onContinue: () {
          if (formKey.currentState!.validate()) {
            Modular.to.pushNamed(GlobalRoutesApp.readTravelNFCRoute);
          }
        },
        children: [
          const TitleForm(
            title: title,
            description: description,
          ),
          const SizedBox(height: 8.0),
          TitleForm.h2(
            title: titleH2,
            description: descriptionH2,
          ),
          const SizedBox(height: 12.0),
          RegisterTravelForm(formKey: formKey)
        ]);
  }
}
