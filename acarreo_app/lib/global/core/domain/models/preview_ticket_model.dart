import 'package:equatable/equatable.dart';

class PreviewTicketModel extends Equatable {
  final String enterpriseName;
  final String projectName;
  final String date;
  final String location;
  final String material;
  final String plates;
  final String capacity;
  final String description;
  final String barcode;
  final String typeLocation;

  const PreviewTicketModel({
    required this.enterpriseName,
    required this.projectName,
    required this.date,
    required this.location,
    required this.material,
    required this.plates,
    required this.capacity,
    required this.description,
    required this.barcode,
    required this.typeLocation,
  });

  toMap() {
    return {
      'enterpriseName': enterpriseName,
      'projectName': projectName,
      'date': date,
      'location': location,
      'material': material,
      'plates': plates,
      'capacity': capacity,
      'description': description,
      'typeLocation': typeLocation,
      'barcode': barcode,
    };
  }

  @override
  List<Object?> get props => [];
}
