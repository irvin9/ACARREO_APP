import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/ticket_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';

class AcarreoTickeService implements TicketService<AcarreoTicket> {
  final TicketRepository<AcarreoTicket> repository;
  final StorageService storage;

  AcarreoTickeService({required this.repository, required this.storage});

  @override
  createTicket(ticket) async {
    try {
      // final currentUser = await storage.getCurrentUser();
      final newTicket = await repository.createTicket(ticket);
      return newTicket;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  get() async {
    try {
      final currentUser = await storage.getCurrentUser();
      final trucks = await repository.getTicketsByUser(
        currentUser.id.toString(),
      );
      return trucks;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  Future<List<AcarreoTicket>?> update() {
    // TODO: implement update
    throw UnimplementedError();
  }
}
