import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.name,
    required this.fathersLastname,
    required this.id,
    this.updatedAt,
    required this.user,
    required this.createdAt,
    required this.idClient,
    required this.mothersLastname,
    required this.idProject,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        fathersLastname: json["fathers_lastname"],
        id: json["id"],
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
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
  final DateTime? updatedAt;
  final String user;

  @override
  List<Object?> get props => [
        name,
        fathersLastname,
        user,
        idClient,
        idProject,
        mothersLastname,
        idProject,
      ];

  UserModel copyWith({
    String? name,
    String? fathersLastname,
    String? password,
    String? user,
    int? idClient,
    String? mothersLastname,
    int? idProject,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        fathersLastname: fathersLastname ?? this.fathersLastname,
        user: user ?? this.user,
        createdAt: createdAt,
        idClient: idClient ?? this.idClient,
        mothersLastname: mothersLastname ?? this.mothersLastname,
        idProject: idProject ?? this.idProject,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "fathers_lastname": fathersLastname,
        "user": user,
        "id_client": idClient,
        "mothers_lastname": mothersLastname,
        "id_project": idProject,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
