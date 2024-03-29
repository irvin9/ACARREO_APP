import 'dart:convert';

class AcarreoOperatingCompany {
  AcarreoOperatingCompany({
    required this.id,
    required this.address,
    required this.idModule,
    required this.idProject,
    required this.name,
    required this.phone,
    required this.rfc,
    required this.createdAt,
    this.updatedAt,
  });

  factory AcarreoOperatingCompany.fromApiJson(String str) =>
      AcarreoOperatingCompany.fromJson(json.decode(str));

  factory AcarreoOperatingCompany.fromJson(Map<String, dynamic> json) =>
      AcarreoOperatingCompany(
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        idModule: json["id_module"],
        idProject: json["id_project"],
        name: json["name"],
        phone: json["phone"],
        rfc: json["rfc"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  final String address;
  final DateTime createdAt;
  final int id;
  final int idModule;
  final int idProject;
  final String name;
  final String phone;
  final String rfc;
  final DateTime? updatedAt;

  AcarreoOperatingCompany copyWith({
    String? address,
    String? name,
    String? phone,
    String? rfc,
  }) =>
      AcarreoOperatingCompany(
        address: address ?? this.address,
        createdAt: createdAt,
        id: id,
        idModule: idModule,
        idProject: idProject,
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
        "name": name,
        "phone": phone,
        "rfc": rfc,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
