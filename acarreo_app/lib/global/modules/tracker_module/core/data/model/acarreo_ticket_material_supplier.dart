import 'dart:convert';

class AcarreoTicketMaterialSupplier {
  AcarreoTicketMaterialSupplier({
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
    this.updatedAt,
    required this.createdAt,
  });

  factory AcarreoTicketMaterialSupplier.fromApiJson(String str) =>
      AcarreoTicketMaterialSupplier.fromJson(json.decode(str));

  factory AcarreoTicketMaterialSupplier.fromJson(Map<String, dynamic> json) =>
      AcarreoTicketMaterialSupplier(
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
      );

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
        folioExternalTicket: answers["folio_ticket_origin"],
        folioBank: answers["folio_bank"],
        description: answers["description"],
        createdAt: DateTime.now(),
        updatedAt: null,
      );

  final DateTime date;
  final String description;
  final String folioBank;
  final String folioExternalTicket;
  final String folioTicket;
  final int idClient;
  final int idCustomer;
  final int idExportCompany;
  final int idLocation;
  final int idMaterial;
  final int idTruck;
  final int idProject;
  final int idTracker;
  final DateTime createdAt;
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
