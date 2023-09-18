import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/concept_text_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class PreviewTicketTravelScreen extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  const PreviewTicketTravelScreen(
      {super.key, this.currentStep, this.totalSteps});

  @override
  Widget build(BuildContext context) {
    const String title = 'Revisa el ticker generado';

    return GeneralTrackerWrap(
      onContinue: () => Modular.to.pushNamedAndRemoveUntil(
          GlobalRoutesApp.registerTravelRoute, (p0) => false),
      currentStep: currentStep,
      children: [
        const TitleForm(
          title: title,
          titleTextSize: 24,
          spacing: 8.0,
        ),
        Card(
          elevation: 0.5,
          color: Colors.white,
          child: const Column(
            children: [
              ConceptTextTicket(
                conceptText: 'Empresa:',
                valueText: 'VIAS AZVINDI',
              ),
              ConceptTextTicket(
                conceptText: 'Obra:',
                valueText: 'SUPERESTRUCTURA AZVINDI 13',
              ),
              ConceptTextTicket(
                conceptText: 'Ubicación:',
                valueText: 'FLAMBOYANES ACOPIO',
              ),
              ConceptTextTicket(
                conceptText: 'Material:',
                valueText: 'BALASTO SENCILLO',
              ),
              ConceptTextTicket(
                conceptText: 'Placas:',
                valueText: '22UH6D',
              ),
              ConceptTextTicket(
                conceptText: 'Marca:',
                valueText: 'INDEFINIDA',
              ),
              ConceptTextTicket(
                conceptText: 'M3:',
                valueText: '28,00',
              ),
              ConceptTextTicket(
                conceptText: 'Nota:',
                valueText: '(PROGRESO) (NORDIC MERCHANTS)',
              ),
              ConceptTextTicket(
                conceptText: 'Fecha:',
                valueText: '2023/jul/06 10:06:48 p m',
              )
            ],
          ).withPaddingSymmetric(vertical: 12.0, horizontal: 12.0),
        )
      ],
    );
  }
}
