import 'package:flutter/services.dart';
import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class StartxpandPrinterBluetoothService {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  getImageData(String asset) async {
    final ByteData byteData = await rootBundle.load(asset);
    return byteData.buffer.asUint8List();
  }

  Future<bool> print(StarXpandPrinter printer) async {
    final doc = StarXpandDocument();
    final printDoc = StarXpandDocumentPrint();

    try {
      doc.addPrint(printDoc);
      doc.addDrawer(StarXpandDocumentDrawer());
      StarXpand.printDocument(printer, doc);
      return true;
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
