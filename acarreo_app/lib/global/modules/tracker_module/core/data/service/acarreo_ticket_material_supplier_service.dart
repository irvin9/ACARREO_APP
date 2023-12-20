import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket_material_supplier.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/repository/ticket_repository.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/service/ticket_service.dart';

class AcarreoTicketMaterialSupplierService
    implements TicketService<AcarreoTicketMaterialSupplier> {
  final TicketRepository<AcarreoTicketMaterialSupplier> repository;
  final StorageService storage;
  final LocalStorageService localStorageService;

  AcarreoTicketMaterialSupplierService({
    required this.repository,
    required this.storage,
    required this.localStorageService,
  }) {
    localStorageService.init(StorageLocalNames.ticketsMaterialSupplier);
  }

  @override
  createTicket(ticket) async {
    try {
      final currentUser = await storage.getCurrentUser();
      final ticketCopy = ticket.copyWith(idTracker: currentUser.id);
      localStorageService.saveBykey(
        ticketCopy.folioTicket,
        ticketCopy.toMap(),
      );
      return ticketCopy;
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
      final items = await localStorageService.getItems();
      final tickets = items
          .cast()
          .map((i) => AcarreoTicketMaterialSupplier.fromJson(i))
          .toList();
      return tickets;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  @override
  Future<List<AcarreoTicketMaterialSupplier>?> update() {
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteTicket(String id) async {
    try {
      await localStorageService.deleteItem(id);
      return true;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  @override
  Future<AcarreoTicketMaterialSupplier?> uploadTicket(
      AcarreoTicketMaterialSupplier ticket) async {
    try {
      final newTicket = await repository.createTicket(ticket);
      return newTicket;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
