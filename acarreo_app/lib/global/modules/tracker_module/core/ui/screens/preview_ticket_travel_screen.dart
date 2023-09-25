import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_truck.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/concept_text_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PreviewTicketTravelScreen extends StatelessWidget {
  final int? currentStep;
  final int? totalSteps;
  const PreviewTicketTravelScreen(
      {super.key, this.currentStep, this.totalSteps});

  @override
  Widget build(BuildContext context) {
    const String title = 'Revisa el ticker generado';
    final bloc = Modular.get<AcarreoCubit>();
    final project = bloc.managerService.project;
    final String? answerTypeLocation = bloc.formAnswers['type_location'];
    final String description = bloc.formAnswers['description'] ?? '';
    final truck = bloc.formAnswers['currentTruck'] as AcarreoTruck;
    final int materialId = int.parse(bloc.getAnswersForm('id_material'));
    final material = bloc.managerService.materials
        .firstWhere((item) => materialId == item.id);
    final int locationId = int.parse(bloc.getAnswersForm('id_location'));
    final location = bloc.managerService.locations
        .firstWhere((item) => item.id == locationId);
    final captureDate =
        DateFormat('dd/MM/yy hh:mm a').format(bloc.formAnswers['date']);
    final ticketCode = bloc.generateTicketCode();

    return GeneralTrackerWrap(
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
                valueText: project?.enterpriseName ?? 'N/A',
              ),
              ConceptTextTicket(
                conceptText: 'Proyecto:',
                valueText: project?.projectName ?? 'N/A',
              ),
              ConceptTextTicket(
                conceptText: 'Fecha:',
                valueText: captureDate,
              ),
              ConceptTextTicket(
                conceptText:
                    FormValues.mappingTypeLocation['1'] == answerTypeLocation
                        ? 'Origen:'
                        : 'Destino:',
                valueText: location.name,
              ),
              ConceptTextTicket(
                conceptText: 'Material:',
                valueText: material.materialName,
              ),
              ConceptTextTicket(
                conceptText: 'Placas:',
                valueText: truck.plate,
              ),
              ConceptTextTicket(
                conceptText: 'M3:',
                valueText: '${truck.capacity} m3',
              ),
              ConceptTextTicket(
                conceptText: 'Nota:',
                valueText: description,
              ),
              BarcodeWidget(
                padding: const EdgeInsets.all(10.0),
                barcode: Barcode.code128(),
                data: ticketCode,
              )
            ],
          ).withPaddingSymmetric(vertical: 12.0, horizontal: 12.0),
        )
      ],
    );
  }
}
