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
  final String? companyName;
  final String? customerName;
  final String? barcodeExternal;

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
    this.companyName,
    this.customerName,
    this.barcodeExternal,
  });

  factory PreviewTicketModel.ticket({
    required String enterpriseName,
    required String projectName,
    required String date,
    required String location,
    required String material,
    required String plates,
    required String capacity,
    required String description,
    required String barcode,
    required String typeLocation,
  }) =>
      PreviewTicketModel(
          enterpriseName: enterpriseName,
          projectName: projectName,
          date: date,
          location: location,
          material: material,
          plates: plates,
          capacity: capacity,
          description: description,
          barcode: barcode,
          typeLocation: typeLocation);

  factory PreviewTicketModel.ticketBank({
    required String enterpriseName,
    required String projectName,
    required String date,
    required String location,
    required String material,
    required String plates,
    required String capacity,
    required String description,
    required String barcode,
    required String typeRegister,
    required String companyName,
    required String customerName,
    required String barcodeExternal,
  }) =>
      PreviewTicketModel(
        enterpriseName: enterpriseName,
        projectName: projectName,
        date: date,
        location: location,
        material: material,
        plates: plates,
        capacity: capacity,
        description: description,
        barcode: barcode,
        typeLocation: typeRegister,
        companyName: companyName,
        customerName: customerName,
        barcodeExternal: barcodeExternal.isNotEmpty ? barcodeExternal : 'N/A',
      );

  Map<String, dynamic> get toMapTicket => {
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

  Map<String, dynamic> get toMapTicketBank => {
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
        'companyName': companyName,
        'customerName': customerName,
        'barcodeExternal': barcodeExternal,
      };

  @override
  List<Object?> get props => [];
}
