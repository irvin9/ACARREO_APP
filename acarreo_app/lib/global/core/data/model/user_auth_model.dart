import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserAuthModel extends Equatable {
  const UserAuthModel({
    required this.name,
    required this.fathersLastname,
    required this.id,
    this.updatedAt,
    // required this.password,
    required this.user,
    required this.createdAt,
    required this.idClient,
    required this.mothersLastname,
    required this.idProject,
  });

  factory UserAuthModel.fromApiJson(String str) =>
      UserAuthModel.fromJson(json.decode(str));

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => UserAuthModel(
        name: json["name"],
        fathersLastname: json["fathers_lastname"],
        id: json["id"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        // password: json["password"],
        user: json["user"],
        createdAt: DateTime.parse(json["created_at"]),
        idClient: json["id_client"],
        mothersLastname: json["mothers_lastname"],
        idProject: json["id_project"],
      );

  final DateTime createdAt;
  final String fathersLastname;
  final int id;
  final int idClient;
  final int idProject;
  final String mothersLastname;
  final String name;
  // final String password;
  final DateTime? updatedAt;
  final String user;

  @override
  List<Object?> get props => [
        name,
        fathersLastname,
        // password,
        user,
        idClient,
        idProject,
        mothersLastname,
        idProject,
      ];

  UserAuthModel copyWith({
    String? name,
    String? fathersLastname,
    // String? password,
    String? user,
    int? idClient,
    String? mothersLastname,
    int? idProject,
  }) =>
      UserAuthModel(
        id: id,
        name: name ?? this.name,
        fathersLastname: fathersLastname ?? this.fathersLastname,
        // password: password ?? this.password,
        user: user ?? this.user,
        createdAt: createdAt,
        idClient: idClient ?? this.idClient,
        mothersLastname: mothersLastname ?? this.mothersLastname,
        idProject: idProject ?? this.idProject,
      );

  String toApiJson() {
    final apiMap = toMap();
    apiMap.remove('id');
    apiMap.remove('created_at');
    apiMap.remove('updated_at');
    return json.encode(apiMap);
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "fathers_lastname": fathersLastname,
        // "password": password,
        "user": user,
        "id_client": idClient,
        "mothers_lastname": mothersLastname,
        "id_project": idProject,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
