import 'dart:convert';

class AcarreoTruck {
  AcarreoTruck({
    required this.branch,
    required this.capacity,
    required this.createdAt,
    required this.driver,
    required this.extraCapacity,
    required this.id,
    required this.idCarrier,
    required this.idClient,
    required this.idProject,
    required this.plate,
    required this.plateGondola,
    required this.idNfc,
    this.updatedAt,
  });

  factory AcarreoTruck.fromApiJson(String str) =>
      AcarreoTruck.fromJson(json.decode(str));

  factory AcarreoTruck.fromJson(Map<String, dynamic> json) => AcarreoTruck(
        branch: json["branch"],
        capacity: json["capacity"],
        createdAt: DateTime.parse(json["created_at"]),
        driver: json["driver"],
        extraCapacity: json["extra_capacity"],
        id: json["id"],
        idCarrier: json["id_carrier"],
        idClient: json["id_client"],
        idProject: json["id_project"],
        plate: json["plate"],
        plateGondola: json["plate_gondola"],
        idNfc: json["id_nfc"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  final String branch;
  final String capacity;
  final DateTime createdAt;
  final String driver;
  final String extraCapacity;
  final int id;
  final int idCarrier;
  final int idClient;
  final int idProject;
  final String plate;
  final String plateGondola;
  final String idNfc;
  final DateTime? updatedAt;

  AcarreoTruck copyWith({
    String? branch,
    String? capacity,
    String? driver,
    String? extraCapacity,
    String? plate,
    String? plateGondola,
  }) =>
      AcarreoTruck(
        branch: branch ?? this.branch,
        capacity: capacity ?? this.capacity,
        createdAt: createdAt,
        driver: driver ?? this.driver,
        extraCapacity: extraCapacity ?? this.extraCapacity,
        id: id,
        idCarrier: idCarrier,
        idClient: idClient,
        idProject: idProject,
        plate: plate ?? this.plate,
        plateGondola: plateGondola ?? this.plateGondola,
        idNfc: idNfc,
        updatedAt: updatedAt,
      );

  Map<String, dynamic> toApiJson() {
    final apiMap = toMap();
    apiMap.remove('id');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return apiMap;
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "branch": branch,
        "capacity": capacity,
        "driver": driver,
        "extra_capacity": extraCapacity,
        "id_carrier": idCarrier,
        "id_client": idClient,
        "id_project": idProject,
        "plate": plate,
        "plate_gondola": plateGondola,
        "id_nfc": idNfc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
