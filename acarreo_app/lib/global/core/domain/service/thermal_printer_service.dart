import 'package:acarreo_app/global/core/domain/models/thermal_printer_device.dart';

abstract class ThermalPrinterService {
  Future<List<ThermalPrinterDevice>?> getPrinters();
  Future<bool> print(ThermalPrinterDevice printer, Map<String, dynamic> data);
  Future<bool> disconnect();
}
