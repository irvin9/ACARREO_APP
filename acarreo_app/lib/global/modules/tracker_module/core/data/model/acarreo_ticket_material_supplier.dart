import 'dart:convert';

import 'package:acarreo_app/global/modules/tracker_module/core/domain/model/ticket.dart';

class AcarreoTicketMaterialSupplier implements Ticket {
  AcarreoTicketMaterialSupplier({
    required this.id,
    required this.date,
    required this.idExportCompany,
    required this.idCustomer,
    required this.idTracker,
    required this.idLocation,
    required this.idMaterial,
    required this.idClient,
    required this.idProject,
    required this.idTruck,
    required this.folioTicket,
    required this.folioExternalTicket,
    required this.folioBank,
    required this.description,
    required this.typeRegister,
    this.updatedAt,
    required this.createdAt,
  });

  factory AcarreoTicketMaterialSupplier.fromApiJson(String str) =>
      AcarreoTicketMaterialSupplier.fromJson(json.decode(str));

  factory AcarreoTicketMaterialSupplier.fromForm(
          Map<String, dynamic> answers) =>
      AcarreoTicketMaterialSupplier(
        date: answers["date"],
        idExportCompany: int.parse(answers["id_company"]),
        idCustomer: int.parse(answers["id_customer"]),
        idTracker: answers["id_tracker"],
        idLocation: int.parse(answers["id_location"]),
        idMaterial: int.parse(answers["id_material"]),
        idClient: answers["id_client"],
        idProject: answers["id_project"],
        folioTicket: answers["folio_ticket"],
        idTruck: answers["id_truck"],
        folioExternalTicket: answers["folio_ticket_origin"] ?? '',
        folioBank: answers["folio_bank"] ?? '',
        description: answers["description"] ?? '',
        createdAt: DateTime.now(),
        updatedAt: null,
        id: null,
        typeRegister: answers['typeRegister'],
      );

  factory AcarreoTicketMaterialSupplier.fromJson(Map<String, dynamic> json) =>
      AcarreoTicketMaterialSupplier(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        idExportCompany: json["id_export_company"],
        idCustomer: json["id_customer"],
        idTracker: json["id_tracker"],
        idLocation: json["id_location"],
        idMaterial: json["id_material"],
        idClient: json["id_client"],
        idTruck: json["id_truck"],
        idProject: json["id_project"],
        folioTicket: json["folio_ticket"],
        folioExternalTicket: json["folio_external_ticket"],
        folioBank: json["folio_bank"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        typeRegister: json['typeRegister'],
      );

  final String folioBank;
  final String folioExternalTicket;
  final int idCustomer;
  final int idExportCompany;
  final int idLocation;
  final int idTracker;
  @override
  final int idTruck;

  @override
  final DateTime createdAt;

  @override
  final DateTime date;

  @override
  final String description;

  @override
  final String folioTicket;

  @override
  final int? id;

  @override
  final int idClient;

  @override
  final int idMaterial;

  @override
  final int idProject;

  @override
  final int? typeRegister;

  @override
  final DateTime? updatedAt;

  AcarreoTicketMaterialSupplier copyWith({
    int? idTracker,
    DateTime? date,
    String? folioTicket,
    String? folioExternalTicket,
    String? folioBank,
    String? description,
  }) =>
      AcarreoTicketMaterialSupplier(
        id: id,
        date: date ?? this.date,
        idExportCompany: idExportCompany,
        idCustomer: idCustomer,
        idTracker: idTracker ?? this.idTracker,
        idLocation: idLocation,
        idMaterial: idMaterial,
        idClient: idClient,
        idProject: idProject,
        idTruck: idTruck,
        folioTicket: folioTicket ?? this.folioTicket,
        folioExternalTicket: folioExternalTicket ?? this.folioExternalTicket,
        folioBank: folioBank ?? this.folioBank,
        description: description ?? this.description,
        createdAt: createdAt,
        updatedAt: updatedAt,
        typeRegister: typeRegister,
      );

  Map<String, dynamic> toMap() => {
        "id_export_company": idExportCompany,
        "id_customer": idCustomer,
        "id_tracker": idTracker,
        "id_location": idLocation,
        "id_material": idMaterial,
        "id_truck": idTruck,
        "id_client": idClient,
        "id_project": idProject,
        "folio_ticket": folioTicket,
        "folio_external_ticket": folioExternalTicket,
        "folio_bank": folioBank,
        "description": description,
        "date": date.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
