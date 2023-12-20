import 'dart:convert';

class AcarreoCustomer {
  AcarreoCustomer({
    required this.id,
    required this.address,
    required this.idModule,
    required this.idProject,
    // required this.idClient,
    required this.name,
    required this.phone,
    required this.rfc,
    required this.createdAt,
    this.updatedAt,
  });

  factory AcarreoCustomer.fromApiJson(String str) =>
      AcarreoCustomer.fromJson(json.decode(str));

  factory AcarreoCustomer.fromJson(Map<String, dynamic> json) =>
      AcarreoCustomer(
        address: json["address"],
        id: json["id"],
        idModule: json["id_module"],
        idProject: json["id_project"],
        // idClient: json["id_client"],
        name: json["name"],
        phone: json["phone"],
        rfc: json["rfc"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  final String address;
  final DateTime createdAt;
  final int id;
  final int idModule;
  final int idProject;
  // final int idClient;
  final String name;
  final String phone;
  final String rfc;
  final DateTime? updatedAt;

  AcarreoCustomer copyWith({
    String? address,
    String? name,
    String? phone,
    String? rfc,
  }) =>
      AcarreoCustomer(
        address: address ?? this.address,
        createdAt: createdAt,
        id: id,
        idModule: idModule,
        idProject: idProject,
        // idClient: idClient,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        rfc: rfc ?? this.rfc,
        updatedAt: updatedAt,
      );

  String toApiJson() {
    toJson().remove('id');
    toJson().remove('id_client');
    toJson().remove('id_project');
    toJson().remove('id_module');
    toJson().remove('id_label');
    toJson().remove('created_at');
    toJson().remove('updated_at');
    return json.encode(toJson());
  }

  Map<String, dynamic> toJson() => {
        "address": address,
        "id": id,
        "id_module": idModule,
        "id_project": idProject,
        // "id_client": idClient,
        "name": name,
        "phone": phone,
        "rfc": rfc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
