import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/nfc/nfc_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/read_nfc_form.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_error.dart';
import 'package:flutter/material.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';

class ReadNFCTravelScreen extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;

  const ReadNFCTravelScreen(
      {super.key, this.currentStep = 1, this.totalSteps = 4});

  @override
  Widget build(BuildContext context) {
    const String title = 'Identifica tu Unidad';
    const String description =
        'Leeremos su código de indentificación mediante un lector NFC.';

    return BlocConsumer<NfcCubit, NfcState>(
      listener: (context, state) {
        if (state is NfcScanSuccess) {
          Modular.to.pushNamed(GlobalRoutesApp.detailsTicketTravelRoute);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.data)));
        }

        if (state is NfcScanFailed) {
          DialogError.show(
            context,
            DialogMessageModel.fromMap(state.message),
            () => Modular.to
                .pushReplacementNamed(GlobalRoutesApp.registerTravelRoute),
          );
        }
      },
      builder: (context, state) {
        return GeneralTrackerWrap(
            currentStep: currentStep,
            onContinue: () =>
                Modular.to.pushNamed(GlobalRoutesApp.detailsTicketTravelRoute),
            children: const [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleForm(
                    title: title,
                    description: description,
                  ),
                  SizedBox(height: 8.0),
                  ReadNFCForm()
                ],
              )
            ]);
      },
    );
  }
}
