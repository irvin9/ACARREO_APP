import 'dart:convert';

class AcarreoTicket {
  final DateTime createdAt;
  final DateTime date;
  final String description;
  final String folio;
  final int? id;
  final int idClient;
  final int? idEndTravel;
  final int idMaterial;
  final int idProject;
  final int idStartTravel;
  final int? idTracker;
  final int idTruck;
  final String folioTicket;
  final int typeLocation;
  final DateTime? updatedAt;

  AcarreoTicket({
    this.id,
    required this.date,
    required this.description,
    required this.folio,
    required this.idClient,
    this.idEndTravel,
    required this.idMaterial,
    required this.idProject,
    required this.idStartTravel,
    required this.idTracker,
    required this.idTruck,
    required this.folioTicket,
    required this.typeLocation,
    this.updatedAt,
    required this.createdAt,
  });

  AcarreoTicket copyWith(
          {DateTime? date,
          String? description,
          String? folio,
          int? idTracker}) =>
      AcarreoTicket(
        createdAt: createdAt,
        date: date ?? this.date,
        description: description ?? this.description,
        folio: folio ?? this.folio,
        id: id,
        idClient: idClient,
        idEndTravel: idEndTravel,
        idMaterial: idMaterial,
        idProject: idProject,
        idStartTravel: idStartTravel,
        idTracker: idTracker ?? this.idTracker,
        idTruck: idTruck,
        folioTicket: folioTicket,
        typeLocation: typeLocation,
        updatedAt: updatedAt,
      );

  factory AcarreoTicket.fromRawJson(String str) =>
      AcarreoTicket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory AcarreoTicket.fromJson(Map<String, dynamic> json) => AcarreoTicket(
        createdAt: DateTime.parse(json["created_at"]),
        date: DateTime.parse(json["date"]),
        description: json["description"],
        folio: json["folio"],
        typeLocation: json["type_location"],
        folioTicket: json["folio_origin"] ?? json["folio_ticket"],
        id: json["id"],
        idClient: json["id_client"],
        idEndTravel: json["id_end_travel"],
        idMaterial: json["id_material"],
        idProject: json["id_project"],
        idStartTravel: json["id_start_travel"],
        idTracker: json["id_tracker"],
        idTruck: json["id_truck"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  factory AcarreoTicket.fromForm(Map<String, dynamic> answers) => AcarreoTicket(
        createdAt: DateTime.now(),
        date: answers["date"],
        description: answers["description"],
        folio: answers["folio"],
        typeLocation: answers["type_location"] == 'origen' ? 1 : 2,
        folioTicket: answers["folioId"],
        id: null,
        idClient: answers["id_client"],
        idEndTravel: int.parse(answers["id_location"]),
        idMaterial: int.parse(answers["id_material"]),
        idProject: answers["id_project"],
        idStartTravel: int.parse(answers["id_location"]),
        idTracker: 0,
        idTruck: answers["id_truck"],
        updatedAt: null,
      );

  Map<String, dynamic> toApiJson() {
    assert(idTracker != null);
    final apiMap = toMap();
    apiMap.remove('id');
    apiMap['folio_ticket'] = apiMap.remove('folio_ticket');
    apiMap.remove('type_location');
    apiMap.remove('id_start_travel');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return apiMap;
  }

  Map<String, dynamic> toTicketOrigenJson() {
    assert(idTracker != null);
    final apiMap = toMap();
    apiMap['folio_origin'] = apiMap.remove('folio_ticket');
    apiMap['id_end_travel'] = -1;
    apiMap.remove('id');
    apiMap.remove('type_location');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return apiMap;
  }

  Map<String, dynamic> toTicketDestinationJson() {
    assert(idTracker != null);
    final apiMap = toMap();
    apiMap.remove('id');
    apiMap['folio_origin'] = apiMap.remove('folio_ticket');
    apiMap.remove('type_location');
    apiMap.remove('id_start_travel');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return apiMap;
  }

  Map<String, dynamic> toMap() => {
        "created_at": createdAt.toIso8601String(),
        "date": date.toIso8601String(),
        "description": description,
        "folio": folio,
        "id_client": idClient,
        "type_location": typeLocation,
        "folio_ticket": folioTicket,
        "id_end_travel": idEndTravel,
        "id_material": idMaterial,
        "id_project": idProject,
        "id_start_travel": idStartTravel,
        "id_tracker": idTracker,
        "id_truck": idTruck,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
