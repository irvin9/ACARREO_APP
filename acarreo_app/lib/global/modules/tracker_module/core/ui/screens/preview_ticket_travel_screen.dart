import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/concept_text_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_printting.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class PreviewTicketTravelScreen extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  const PreviewTicketTravelScreen(
      {super.key, this.currentStep, this.totalSteps});

  @override
  Widget build(BuildContext context) {
    const String title = 'Revisa el ticker generado';
    final bloc = Modular.get<AcarreoCubit>();
    final String? answerTypeLocation = bloc.formAnswers['type_location'];
    bloc.generateTicketCode();
    final Map<String, dynamic> ticketData = bloc.formatTicket();

    return BlocListener<AcarreoCubit, AcarreoState>(
      listener: (context, state) {
        if (state is AcarreoShowModalTicketPrint) {
          DialogPritting.show(
            context,
            DialogMessageModel(
              title: '¡Vamos a imprimir su ticket!',
              description:
                  'Para eso necesitamos que tenga ya conectada su impresora al dispositivo.',
            ),
          );
        }
      },
      child: GeneralTrackerWrap(
        mainButtonText: 'Generar Ticket',
        onContinue: () {
          bloc.createTicket();
        },
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
            child: Column(
              children: [
                ConceptTextTicket(
                  conceptText: 'Desarrolladora:',
                  valueText: ticketData['projectName'],
                ),
                ConceptTextTicket(
                  conceptText: 'Proyecto:',
                  valueText: ticketData['projectName'],
                ),
                ConceptTextTicket(
                  conceptText: 'Fecha:',
                  valueText: ticketData['date'],
                ),
                ConceptTextTicket(
                  conceptText: 'Tipo de viaje:',
                  valueText:
                      FormValues.mappingTypeLocation['1'] == answerTypeLocation
                          ? 'Origen'
                          : 'Destino',
                ),
                ConceptTextTicket(
                  conceptText: 'Ubicación:',
                  valueText: ticketData['location'],
                ),
                ConceptTextTicket(
                  conceptText: 'Material:',
                  valueText: ticketData['material'],
                ),
                ConceptTextTicket(
                  conceptText: 'Placas:',
                  valueText: ticketData['plates'],
                ),
                ConceptTextTicket(
                  conceptText: 'M3:',
                  valueText: '${ticketData['capacity']} m3',
                ),
                ConceptTextTicket(
                  conceptText: 'Nota:',
                  valueText: ticketData['description'],
                ),
                BarcodeWidget(
                  padding: const EdgeInsets.all(10.0),
                  barcode: Barcode.code128(),
                  data: ticketData['barcode'],
                )
              ],
            ).withPaddingSymmetric(vertical: 12.0, horizontal: 12.0),
          )
        ],
      ),
    );
  }
}
