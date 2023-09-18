import 'dart:convert';

class ClientModel {
  ClientModel({
    required this.createdAt,
    required this.updatedAt,
    required this.rfc,
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        rfc: json["rfc"],
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
      );

  factory ClientModel.fromRawJson(String str) =>
      ClientModel.fromJson(json.decode(str));

  final String address;
  final DateTime createdAt;
  final int id;
  final String name;
  final String phone;
  final String rfc;
  final DateTime? updatedAt;

  ClientModel copyWith({
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rfc,
    int? id,
    String? name,
    String? phone,
    String? address,
  }) =>
      ClientModel(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        rfc: rfc ?? this.rfc,
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rfc": rfc,
        "id": id,
        "name": name,
        "phone": phone,
        "address": address,
      };
}
