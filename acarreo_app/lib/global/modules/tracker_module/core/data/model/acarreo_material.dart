import 'dart:convert';

class AcarreoMaterial {
  AcarreoMaterial({
    required this.createdAt,
    required this.id,
    required this.idClient,
    required this.idProject,
    required this.idModule,
    required this.materialName,
    required this.materialPrice,
    required this.state,
    required this.travelMode,
    required this.travelPrice,
    required this.truck,
    this.updatedAt,
  });

  factory AcarreoMaterial.fromApiJson(String str) =>
      AcarreoMaterial.fromJson(json.decode(str));

  factory AcarreoMaterial.fromJson(Map<String, dynamic> json) =>
      AcarreoMaterial(
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        idClient: json["id_client"],
        idProject: json["id_project"],
        idModule: json["id_module"],
        materialName: json["material_name"],
        materialPrice: json["material_price"],
        state: json["state"],
        travelMode: json["travel_mode"],
        travelPrice: json["travel_price"],
        truck: json["truck"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  final DateTime createdAt;
  final int id;
  final int idClient;
  final int idProject;
  final int idModule;
  final String materialName;
  final String materialPrice;
  final String state;
  final String travelMode;
  final String travelPrice;
  final String truck;
  final DateTime? updatedAt;

  AcarreoMaterial copyWith({
    String? materialName,
    String? materialPrice,
    String? state,
    String? travelMode,
    String? travelPrice,
    String? truck,
  }) =>
      AcarreoMaterial(
        createdAt: createdAt,
        id: id,
        idClient: idClient,
        idProject: idProject,
        idModule: idModule,
        materialName: materialName ?? this.materialName,
        materialPrice: materialPrice ?? this.materialPrice,
        state: state ?? this.state,
        travelMode: travelMode ?? this.travelMode,
        travelPrice: travelPrice ?? this.travelPrice,
        truck: truck ?? this.truck,
        updatedAt: updatedAt,
      );

  String toApiJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "id_client": idClient,
        "id_project": idProject,
        "id_module": idModule,
        "material_name": materialName,
        "material_price": materialPrice,
        "state": state,
        "travel_mode": travelMode,
        "travel_price": travelPrice,
        "truck": truck,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
