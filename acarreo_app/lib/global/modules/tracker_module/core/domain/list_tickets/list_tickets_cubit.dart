import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';

part 'list_tickets_state.dart';

class ListTicketsCubit extends Cubit<ListTicketsState> {
  final AcarreoDataManagerService managerService;

  ListTicketsCubit(this.managerService) : super(const InitListTicket());

  Future<void> getTickets() async {
    emit(const LoadTickets());
    final tickets = await managerService.ticketService.get();
    await Future.delayed(const Duration(seconds: 1));
    if (tickets != null) {
      emit(LoadTicketsSuccess(tickets));
      return;
    }
    emit(const LoadTicketsError());
  }
}
