import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:intl/intl.dart';

part 'list_tickets_state.dart';

class ListTicketsCubit extends Cubit<ListTicketsState> {
  final AcarreoDataManagerService managerService;

  late AcarreoTicket selectedTicket;

  ListTicketsCubit(this.managerService) : super(const InitListTicket());

  Future<void> getTickets() async {
    emit(const LoadTickets());
    final tickets = await managerService.ticketService.get();
    await Future.delayed(const Duration(seconds: 1));
    if (tickets != null) {
      tickets.sort(((a, b) => b.createdAt.compareTo(a.date)));
      emit(LoadTicketsSuccess(tickets));
      return;
    }
    emit(const LoadTicketsError());
  }

  Future<void> goToTicketScreen(AcarreoTicket ticket) async {
    selectedTicket = ticket;
    Modular.to.pushNamed(GlobalRoutesApp.reviewTicketRoute);
  }

  PreviewTicketModel formatTicket() {
    final project = managerService.project;
    final String description = selectedTicket.description;
    final truck =
        managerService.trucks.firstWhere((t) => t.id == selectedTicket.idTruck);
    final material = managerService.materials
        .firstWhere((m) => m.id == selectedTicket.idMaterial);
    final location = managerService.locations
        .firstWhere((l) => l.id == selectedTicket.idStartTravel);
    final captureDate =
        DateFormat('dd/MM/yy hh:mm a').format(selectedTicket.createdAt);
    final String ticketCode = selectedTicket.folioTicket;
    final String typeRegister = selectedTicket.typeRegister.toString();

    return PreviewTicketModel(
      enterpriseName: project?.enterpriseName ?? 'N/A',
      projectName: project?.projectName ?? 'N/A',
      date: captureDate,
      material: material.materialName,
      plates: truck.plate,
      capacity: truck.capacity,
      description: description,
      location: location.name,
      barcode: ticketCode,
      typeLocation: typeRegister,
    );
  }
}
