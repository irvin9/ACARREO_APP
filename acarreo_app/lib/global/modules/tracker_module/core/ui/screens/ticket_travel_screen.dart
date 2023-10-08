import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/cubit/acarreo/acarreo_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/list_tickets/list_tickets_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/preview_details_ticket.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_printting.dart';
import 'package:flutter/material.dart';

class TicketTravelScreen extends StatelessWidget {
  const TicketTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listTicketCubit = Modular.get<ListTicketsCubit>();
    final PreviewTicketModel ticketData = listTicketCubit.formatTicket();
    return BlocListener<AcarreoCubit, AcarreoState>(
      listener: (context, state) {
        if (state is AcarreoShowModalTicketPrint) {
          DialogPritting.show(
            context,
            DialogMessageModel(
              title: '¡Vamos a reimprimir su ticket!',
              description:
                  'Para eso necesitamos que tenga ya conectada su impresora al dispositivo.',
            ),
          );
        }
      },
      child: GeneralTrackerWrap(
        mainButtonText: 'Reimprimir Ticket',
        onContinue: () {
          // listTicketCubit.createTicket();
        },
        showStepper: false,
        children: [PreviewDetailsTicket(ticketData: ticketData)],
      ),
    );
  }
}
