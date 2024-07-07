import 'package:acarreo_app/global/core/domain/models/thermal_printer_device.dart';

abstract class ThermalPrinterService<T> {
  Future<List<ThermalPrinterDevice>?> getPrinters();
  Future<bool> print(T printer, Map<String, dynamic> data);
}
