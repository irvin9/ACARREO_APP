import 'package:acarreo_app/global/core/utils/extensions/string_utils/string_utils_extension.dart';
import 'package:acarreo_app/global/core/domain/models/thermal_printer_device.dart';
import 'package:acarreo_app/global/core/domain/service/thermal_printer_service.dart';

import 'package:flutter/services.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart'
    hide BluetoothService;

import '../../domain/service/bluetooth_service.dart';

class StartxpandThermalPrinterService implements ThermalPrinterService {
  final BluetoothService btnService;

  List<StarXpandPrinter> _printers = [];

  StartxpandThermalPrinterService({required this.btnService});

  Future<Uint8List> getImageData(String asset) async {
    final ByteData byteData = await rootBundle.load(asset);
    return byteData.buffer.asUint8List();
  }

  Future<void> _appendMainLogo(
      StarXpandDocument doc, StarXpandDocumentPrint printDoc) async {
    final logoImage = await getImageData('assets/logo/logo-icon.png');
    printDoc.style(alignment: StarXpandStyleAlignment.center);
    printDoc.actionPrintImage(logoImage, 350);
    printDoc.actionFeedLine(1);
  }

  void appendBody(StarXpandDocument doc, StarXpandDocumentPrint printDoc,
      Map<String, dynamic> data) {
    String typeLocation =
        FormValues.typeRegisters["${data['typeLocation']}"] ?? '';

    printDoc.style(alignment: StarXpandStyleAlignment.left);
    printDoc.actionPrintText("Desarrolladora: ${data['enterpriseName']}\n"
            "Proyecto: ${data['projectName']}\n"
            "Fecha:  ${data['date']}\n"
            "Tipo de viaje: $typeLocation\n"
            "Ubicacion: ${data['location']}\n"
            "Material: ${data['material']}\n"
            "Placas:  ${data['plates']}\n"
            "M3: ${data['capacity']} m3\n"
            "Nota: ${data['description']}"
        .replaceDiacritics());
  }

  void _appendBarCode(
      StarXpandDocument doc, StarXpandDocumentPrint printDoc, String barcode) {
    printDoc.style(alignment: StarXpandStyleAlignment.center);
    printDoc.actionFeedLine(1);
    printDoc.actionPrintBarcode(
      barcode,
      symbology: StarXpandBarcodeSymbology.code128,
      printHri: true,
    );
  }

  void _appendWebSite(StarXpandDocument doc, StarXpandDocumentPrint printDoc) {
    printDoc.actionFeedLine(1);
    printDoc.style(alignment: StarXpandStyleAlignment.center);
    printDoc.actionPrintText("www.truckinginnovation.com\n");
    printDoc.actionFeedLine(4);
  }

  @override
  Future<bool> print(
      ThermalPrinterDevice printer, Map<String, dynamic> data) async {
    final doc = StarXpandDocument();
    final printDoc = StarXpandDocumentPrint();

    try {
      final starXpandPrinter =
          _printers.firstWhere((p) => p.identifier == printer.identifier);

      await _appendMainLogo(doc, printDoc);
      appendBody(doc, printDoc, data);
      _appendBarCode(doc, printDoc, data['barcode']);
      _appendWebSite(doc, printDoc);
      printDoc.actionCut(StarXpandCutType.partial);

      doc.addPrint(printDoc);
      doc.addDrawer(StarXpandDocumentDrawer());
      final status = await StarXpand.printDocument(starXpandPrinter, doc)
          .timeout(const Duration(seconds: 20));
      return status;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  @override
  Future<bool> disconnect() async {
    return true;
  }

  @override
  Future<List<ThermalPrinterDevice>?> getPrinters() async {
    try {
      final isBluetoothOn = await btnService.isOnBluetooth;
      if (!isBluetoothOn) throw Exception('Bluetooth don\'t available.');
      _printers = await StarXpand.findPrinters()
          .timeout(const Duration(seconds: 10), onTimeout: () => []);
      return _printers
          .map((p) => ThermalPrinterDevice(
              name: p.model.label, identifier: p.identifier))
          .toList();
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}
