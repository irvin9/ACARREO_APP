import 'package:flutter/services.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class StartxpandPrinterBluetoothService {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

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
    printDoc.style(alignment: StarXpandStyleAlignment.left);

    printDoc.actionPrintText("Desarrolladora: ${data['enterpriseName']}\n"
        "Proyecto: ${data['projectName']}\n"
        "Fecha:  ${data['date']}\n"
        "Ubicación: ${data['location']}\n"
        "Material: ${data['material']}\n"
        "Placas:  ${data['plates']}\n"
        "M3: ${data['capacity']} m3\n"
        "Nota: ${data['description']}");
  }

  Future<void> _appendSecondaryLogo(
      StarXpandDocument doc, StarXpandDocumentPrint printDoc) async {
    final isotypeImage = await getImageData('assets/logo/logo-icon.png');
    printDoc.style(alignment: StarXpandStyleAlignment.right);
    printDoc.actionPrintImage(isotypeImage, 150);
  }

  void _appendBarCode(
      StarXpandDocument doc, StarXpandDocumentPrint printDoc, String barcode) {
    printDoc.style(alignment: StarXpandStyleAlignment.center);
    printDoc.actionFeedLine(1);
    printDoc.actionPrintBarcode(barcode,
        symbology: StarXpandBarcodeSymbology.code128,
        barDots: 1,
        height: 10.0,
        printHri: true);
  }

  void _appendWebSite(StarXpandDocument doc, StarXpandDocumentPrint printDoc) {
    printDoc.actionFeedLine(1);
    printDoc.style(alignment: StarXpandStyleAlignment.center);
    printDoc.actionPrintText("www.truckinginnovation.com\n");
    printDoc.actionFeedLine(4);
  }

  Future<bool> print(
      StarXpandPrinter printer, Map<String, dynamic> data) async {
    final doc = StarXpandDocument();
    final printDoc = StarXpandDocumentPrint();

    try {
      await _appendMainLogo(doc, printDoc);
      appendBody(doc, printDoc, data);
      await _appendSecondaryLogo(doc, printDoc);
      _appendBarCode(doc, printDoc, data['barcode']);
      _appendWebSite(doc, printDoc);

      doc.addPrint(printDoc);
      doc.addDrawer(StarXpandDocumentDrawer());
      final status = await StarXpand.printDocument(printer, doc)
          .timeout(const Duration(seconds: 30));
      return status;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return false;
    }
  }

  Future<List<StarXpandPrinter>?> getPrinters() async {
    try {
      final isBluetoothOn = await flutterBlue.isOn;
      if (!isBluetoothOn) throw Exception('Bluetooth dont available.');
      final printers =
          await StarXpand.findPrinters().timeout(const Duration(seconds: 10));
      return printers;
    } catch (e, s) {
      debugPrint('Exception on -> ${runtimeType.toString()}');
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      return null;
    }
  }

  goToSettingBLE() {
    OpenSettings.openBluetoothSetting();
  }
}
