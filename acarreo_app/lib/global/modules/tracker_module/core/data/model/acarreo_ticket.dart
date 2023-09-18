import 'dart:convert';

class AcarreoTicket {
  final DateTime createdAt;
  final DateTime date;
  final String description;
  final String folio;
  final int id;
  final int idClient;
  final int idEndTravel;
  final int idMaterial;
  final int idProject;
  final int idStartTravel;
  final int idTracker;
  final int idTruck;
  final DateTime? updatedAt;

  AcarreoTicket({
    required this.createdAt,
    required this.date,
    required this.description,
    required this.folio,
    required this.id,
    required this.idClient,
    required this.idEndTravel,
    required this.idMaterial,
    required this.idProject,
    required this.idStartTravel,
    required this.idTracker,
    required this.idTruck,
    required this.updatedAt,
  });

  AcarreoTicket copyWith({
    DateTime? createdAt,
    DateTime? date,
    String? description,
    String? folio,
    int? id,
    int? idClient,
    int? idEndTravel,
    int? idMaterial,
    int? idProject,
    int? idStartTravel,
    int? idTracker,
    int? idTruck,
    DateTime? updatedAt,
  }) =>
      AcarreoTicket(
        createdAt: createdAt ?? this.createdAt,
        date: date ?? this.date,
        description: description ?? this.description,
        folio: folio ?? this.folio,
        id: id ?? this.id,
        idClient: idClient ?? this.idClient,
        idEndTravel: idEndTravel ?? this.idEndTravel,
        idMaterial: idMaterial ?? this.idMaterial,
        idProject: idProject ?? this.idProject,
        idStartTravel: idStartTravel ?? this.idStartTravel,
        idTracker: idTracker ?? this.idTracker,
        idTruck: idTruck ?? this.idTruck,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory AcarreoTicket.fromRawJson(String str) =>
      AcarreoTicket.fromJson(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory AcarreoTicket.fromJson(Map<String, dynamic> json) => AcarreoTicket(
        createdAt: DateTime.parse(json["created_at"]),
        date: DateTime.parse(json["date"]),
        description: json["description"],
        folio: json["folio"],
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

  Map<String, dynamic> toApiJson() {
    final apiMap = toMap();
    apiMap.remove('id');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return apiMap;
  }

  Map<String, dynamic> toMap() => {
        "created_at": createdAt.toIso8601String(),
        "date": date.toIso8601String(),
        "description": description,
        "folio": folio,
        "id": id,
        "id_client": idClient,
        "id_end_travel": idEndTravel,
        "id_material": idMaterial,
        "id_project": idProject,
        "id_start_travel": idStartTravel,
        "id_tracker": idTracker,
        "id_truck": idTruck,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
