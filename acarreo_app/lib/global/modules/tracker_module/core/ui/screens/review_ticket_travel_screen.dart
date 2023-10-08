import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/list_tickets/list_tickets_cubit.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/ui/widgets/general_tracker_wrap.dart';
import 'package:acarreo_app/global/modules/widgets_module/preview_details_ticket.dart';
import 'package:flutter/material.dart';

class ReviewTicketTravelScreen extends StatelessWidget {
  const ReviewTicketTravelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listTicketCubit = Modular.get<ListTicketsCubit>();
    final PreviewTicketModel ticketData = listTicketCubit.formatTicket();
    return GeneralTrackerWrap(
      mainButtonText: 'Reimprimir Ticket',
      onContinue: () {
        listTicketCubit.printTicket(context);
      },
      showStepper: false,
      children: [PreviewDetailsTicket(ticketData: ticketData)],
    );
  }
}
