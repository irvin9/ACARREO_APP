abstract class TicketRepository<T> {
  Future<List<T>> getTicketsByUser(String id);
  Future<T> createTicket(T ticket);
}
