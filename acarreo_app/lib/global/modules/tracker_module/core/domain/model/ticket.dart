abstract class Ticket {
  Ticket({
    required this.createdAt,
    required this.date,
    required this.description,
    required this.id,
    required this.idTruck,
    required this.idClient,
    required this.idMaterial,
    required this.idProject,
    required this.typeRegister,
    required this.folioTicket,
    required this.updatedAt,
  });

  final DateTime createdAt;
  final DateTime date;
  final String description;
  final String folioTicket;
  final int? id;
  final int idTruck;
  final int idClient;
  final int idMaterial;
  final int idProject;
  final int? typeRegister;
  final DateTime? updatedAt;
}
