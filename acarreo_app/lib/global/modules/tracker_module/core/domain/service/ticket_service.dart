import 'package:acarreo_app/global/core/acarreo_core_module.dart';

abstract class TicketService<T> implements BaseService<T> {
  Future<T?> createTicket(T ticket);
  Future<T?> uploadTicket(T ticket);
  Future<bool> deleteTicket(String id);
}
