import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/widgets_module.dart';
import 'package:flutter/material.dart';

class PreviewTicketTravelScreen extends StatelessWidget {
  final int? currentStep;
  const PreviewTicketTravelScreen({
    super.key,
    this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    const String title = 'Revisa el ticket generado';
    final cubit = Modular.get<AcarreoCubit>();
    final PreviewTicketModel ticketData = cubit.formatTicketByForm();
    return BlocListener<AcarreoCubit, AcarreoState>(
      listener: (context, state) {
        if (state is AcarreoShowModalTicketPrint) {
          DialogPritting.show(
            context: context,
            message: DialogMessageModel(
              title: '¡Vamos a imprimir su ticket!',
              description:
                  'Para eso necesitamos que tenga ya conectada su impresora al dispositivo.',
            ),
            data: cubit.storage.currentUser.idModule == 0
                ? ticketData.toMapTicket
                : ticketData.toMapTicketBank,
            onBack: () => cubit.finishForm(GlobalRoutesApp.registerTravelRoute),
          );
        }
      },
      child: GeneralTrackerWrap(
        mainButtonText: 'Generar Ticket',
        onContinue: () {
          cubit.createTicket();
          Modular.get<NfcCubit>().closeScan();
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
