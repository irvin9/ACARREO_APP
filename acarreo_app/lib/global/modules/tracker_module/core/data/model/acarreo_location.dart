import 'dart:convert';

class AcarreoLocation {
  AcarreoLocation({
    required this.createdAt,
    required this.id,
    required this.idClient,
    required this.idProject,
    required this.latitude,
    required this.longitude,
    required this.type,
    required this.name,
    required this.state,
    required this.idLabel,
    this.updatedAt,
  });

  factory AcarreoLocation.fromApiJson(String str) =>
      AcarreoLocation.fromJson(json.decode(str));

  factory AcarreoLocation.fromJson(Map<String, dynamic> json) =>
      AcarreoLocation(
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        idClient: json["id_client"],
        idProject: json["id_project"],
        idLabel: json["idLabel"] ?? 1,
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
        name: json["name"],
        state: json["state"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  final DateTime createdAt;
  final int id;
  final int idClient;
  final int idProject;
  final String latitude;
  final String type;
  final String longitude;
  final String name;
  final int idLabel;
  final int state;
  final DateTime? updatedAt;

  AcarreoLocation copyWith({
    String? latitude,
    String? longitude,
    String? name,
    int? state,
    String? folio,
    String? type,
  }) =>
      AcarreoLocation(
        createdAt: createdAt,
        id: id,
        idClient: idClient,
        idProject: idProject,
        idLabel: idLabel,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        name: name ?? this.name,
        state: state ?? this.state,
        updatedAt: updatedAt,
        type: type ?? this.type,
      );

  String toApiJson() {
    toJson().remove('id');
    toJson().remove('id_client');
    toJson().remove('id_project');
    toJson().remove('id_label');
    toJson().remove('created_at');
    toJson().remove('updated_at');
    return json.encode(toJson());
  }

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "id_client": idClient,
        "id_project": idProject,
        "id_label": idLabel,
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "state": state,
        "type": type,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
