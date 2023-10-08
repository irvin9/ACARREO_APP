import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/preview_details_ticket.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_printting.dart';
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
    final bloc = Modular.get<AcarreoCubit>();
    bloc.generateTicketCode();
    final PreviewTicketModel ticketData = bloc.formatTicketByForm();
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
          PreviewDetailsTicket(ticketData: ticketData)
        ],
      ),
    );
  }
}
