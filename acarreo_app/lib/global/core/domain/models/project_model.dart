import 'dart:convert';

class ProjectModel {
  ProjectModel({
    required this.createdAt,
    required this.updatedAt,
    required this.projectName,
    required this.id,
    required this.projectCode,
    required this.status,
    required this.enterpriseName,
    required this.idClient,
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) => ProjectModel(
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        projectName: json["project_name"],
        id: json["id"],
        projectCode: json["project_code"],
        status: json["status"],
        enterpriseName: json["enterprise_name"],
        idClient: json["id_client"],
      );

  factory ProjectModel.fromRawJson(String str) =>
      ProjectModel.fromJson(json.decode(str));

  final DateTime createdAt;
  final String enterpriseName;
  final int id;
  final int idClient;
  final int projectCode;
  final String projectName;
  final int status;
  final DateTime? updatedAt;

  ProjectModel copyWith({
    DateTime? createdAt,
    dynamic updatedAt,
    String? projectName,
    int? id,
    int? projectCode,
    int? status,
    String? enterpriseName,
    int? idClient,
  }) =>
      ProjectModel(
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        projectName: projectName ?? this.projectName,
        id: id ?? this.id,
        projectCode: projectCode ?? this.projectCode,
        status: status ?? this.status,
        enterpriseName: enterpriseName ?? this.enterpriseName,
        idClient: idClient ?? this.idClient,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "project_name": projectName,
        "id": id,
        "project_code": projectCode,
        "status": status,
        "enterprise_name": enterpriseName,
        "id_client": idClient,
      };
}
