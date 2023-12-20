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
        date: json["date"],
        idExportCompany: json["id_export_company"],
        idCustomer: json["id_customer"],
        idTracker: json["id_tracker"],
        idLocation: json["id_location"],
        idMaterial: json["id_material"],
        idClient: json["id_client"],
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

  factory AcarreoTicketMaterialSupplier.fromForm(Map<String, dynamic> json) =>
      AcarreoTicketMaterialSupplier(
        date: json["date"],
        idExportCompany: json["id_export_company"],
        idCustomer: json["id_customer"],
        idTracker: json["id_tracker"],
        idLocation: json["id_location"],
        idMaterial: json["id_material"],
        idClient: json["id_client"],
        idProject: json["id_project"],
        folioTicket: json["folio_ticket"],
        folioExternalTicket: json["folio_external_ticket"],
        folioBank: json["folio_bank"],
        description: json["description"],
        createdAt: DateTime.now(),
        updatedAt: null,
      );

  final String date;
  final String description;
  final String folioBank;
  final String folioExternalTicket;
  final String folioTicket;
  final int idClient;
  final int idCustomer;
  final int idExportCompany;
  final int idLocation;
  final int idMaterial;
  final int idProject;
  final int idTracker;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AcarreoTicketMaterialSupplier copyWith({
    int? idTracker,
    String? date,
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
        folioTicket: folioTicket ?? this.folioTicket,
        folioExternalTicket: folioExternalTicket ?? this.folioExternalTicket,
        folioBank: folioBank ?? this.folioBank,
        description: description ?? this.description,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  Map<String, dynamic> toMap() => {
        "date": date,
        "id_export_company": idExportCompany,
        "id_customer": idCustomer,
        "id_tracker": idTracker,
        "id_location": idLocation,
        "id_material": idMaterial,
        "id_client": idClient,
        "id_project": idProject,
        "folio_ticket": folioTicket,
        "folio_external_ticket": folioExternalTicket,
        "folio_bank": folioBank,
        "description": description,
      };
}
