import 'package:acarreo_app/global/core/acarreo_core_module.dart';
import 'package:acarreo_app/global/core/domain/models/preview_ticket_model.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/data/model/acarreo_ticket_material_supplier.dart';
import 'package:acarreo_app/global/modules/tracker_module/core/domain/model/ticket.dart';
import 'package:acarreo_app/global/modules/widgets_module/dialog_printting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

part 'list_tickets_state.dart';

class ListTicketsCubit extends Cubit<ListTicketsState> {
  final AcarreoDataManagerService managerService;
  final StorageService storage = Modular.get<StorageService>();

  ListTicketsCubit(this.managerService) : super(const InitListTicket());

  Future<void> getTickets() async {
    emit(const LoadTickets());
    final currentUser = storage.currentUser;
    final tickets = currentUser.idModule == 0
        ? await managerService.ticketService.get()
        : await managerService.ticketMaterialSupplierService.get();
    await Future.delayed(const Duration(seconds: 1));
    if (tickets != null) {
      tickets.sort(((a, b) => b.createdAt.compareTo(a.date)));
      emit(LoadTicketsSuccess(tickets));
      return;
    }
    emit(const LoadTicketsError());
  }

  Future<void> goToTicketScreen(Ticket ticket) async {
    state.setSelectedTicket = ticket;
    await Modular.to.pushNamed(GlobalRoutesApp.reviewTicketRoute);
  }

  PreviewTicketModel get ticket {
    final ticket = state.selectedTicket as AcarreoTicket;
    final project = managerService.project;
    final String description = ticket.description;
    final truck =
        managerService.trucks.firstWhere((t) => t.id == ticket.idTruck);
    final material =
        managerService.materials.firstWhere((m) => m.id == ticket.idMaterial);
    final location = managerService.locations
        .firstWhere((l) => l.id == ticket.idStartTravel);
    final captureDate = DateFormat('dd/MM/yy hh:mm a').format(ticket.createdAt);
    final String ticketCode = ticket.folioTicket;
    final String typeRegister = ticket.typeRegister.toString();
    return PreviewTicketModel.ticket(
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

  PreviewTicketModel get ticketBank {
    final ticket = state.selectedTicket as AcarreoTicketMaterialSupplier;
    final project = managerService.project;
    final String description = ticket.description;
    final truck =
        managerService.trucks.firstWhere((t) => t.id == ticket.idTruck);
    final material =
        managerService.materials.firstWhere((m) => m.id == ticket.idMaterial);
    final company = managerService.companies
        .firstWhere((m) => m.id == ticket.idExportCompany);
    final customer =
        managerService.customers.firstWhere((m) => m.id == ticket.idCustomer);
    final location =
        managerService.locations.firstWhere((l) => l.id == ticket.idLocation);
    final captureDate = DateFormat('dd/MM/yy hh:mm a').format(ticket.createdAt);

    final externalTicketBarcode = ticket.folioExternalTicket.isNotEmpty
        ? ticket.folioExternalTicket
        : 'N/A';
    return PreviewTicketModel.ticketBank(
      enterpriseName: project?.enterpriseName ?? 'N/A',
      projectName: project?.projectName ?? 'N/A',
      date: captureDate,
      material: material.materialName,
      plates: truck.plate,
      capacity: truck.capacity,
      description: description,
      location: location.name,
      barcode: ticket.folioTicket,
      typeLocation: ticket.typeRegister.toString(),
      companyName: company.name,
      customerName: customer.name,
      barcodeExternal: externalTicketBarcode,
    );
  }

  PreviewTicketModel formatTicket() {
    final currentUser = storage.currentUser;
    return currentUser.idModule == 0 ? ticket : ticketBank;
  }

  printTicket(BuildContext context) {
    final currentUser = storage.currentUser;
    DialogPritting.show(
      context: context,
      message: DialogMessageModel(
        title: '¡Vamos a imprimir su ticket!',
        description:
            'Para eso necesitamos que tenga ya conectada su impresora al dispositivo.',
      ),
      data: currentUser.idModule == 0
          ? formatTicket().toMapTicket
          : formatTicket().toMapTicketBank,
    );
  }
}
