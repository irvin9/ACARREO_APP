import 'dart:convert';

import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class ApiProjectModel extends Equatable {
  final DateTime createdAt;
  final String enterpriseName;
  final int id;
  final int idClient;
  final int projectCode;
  final String projectName;
  final int status;
  final DateTime? updatedAt;

  const ApiProjectModel({
    required this.createdAt,
    required this.enterpriseName,
    required this.id,
    required this.idClient,
    required this.projectCode,
    required this.projectName,
    required this.status,
    required this.updatedAt,
  });

  ApiProjectModel copyWith({
    DateTime? createdAt,
    String? enterpriseName,
    int? id,
    int? idClient,
    int? projectCode,
    String? projectName,
    int? status,
    DateTime? updatedAt,
  }) =>
      ApiProjectModel(
        createdAt: createdAt ?? this.createdAt,
        enterpriseName: enterpriseName ?? this.enterpriseName,
        id: id ?? this.id,
        idClient: idClient ?? this.idClient,
        projectCode: projectCode ?? this.projectCode,
        projectName: projectName ?? this.projectName,
        status: status ?? this.status,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ApiProjectModel.fromJson(String str) =>
      ApiProjectModel.fromMap(json.decode(str));

  String toApiJson() => json.encode(toApiMap());

  factory ApiProjectModel.fromMap(Map<String, dynamic> json) => ApiProjectModel(
        createdAt: DateTime.parse(json["created_at"]),
        enterpriseName: json["enterprise_name"],
        id: json["id"],
        idClient: json["id_client"],
        projectCode: json["project_code"],
        projectName: json["project_name"],
        status: json["status"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toApiMap() {
    final apiMap = toMap();
    apiMap.remove('id');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return apiMap;
  }

  Map<String, dynamic> toMap() => {
        "created_at": createdAt.toIso8601String(),
        "enterprise_name": enterpriseName,
        "id": id,
        "id_client": idClient,
        "project_code": projectCode,
        "project_name": projectName,
        "status": status,
        "updated_at": updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        idClient,
        projectCode,
        enterpriseName,
        projectName,
        status,
        createdAt,
        updatedAt
      ];
}
