import 'package:acarreo_app/global/core/acarreo_core_module.dart';

abstract class TicketService<T> implements BaseService<T> {
  // Future<List<T>?> getTickets();
  Future<T?> createTicket(T ticket);
}
