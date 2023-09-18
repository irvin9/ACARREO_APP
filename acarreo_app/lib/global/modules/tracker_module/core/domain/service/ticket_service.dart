import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';

abstract class TicketService {
  Future<List<AcarreoTicket>?> getTickets();
  Future<AcarreoTicket?> createTicket(AcarreoTicket ticket);
}
