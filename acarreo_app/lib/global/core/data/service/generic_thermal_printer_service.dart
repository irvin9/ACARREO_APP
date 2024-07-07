import 'package:acarreo_app/global/core/domain/models/thermal_printer_device.dart';
import 'package:acarreo_app/global/core/domain/service/thermal_printer_service.dart';

class GenericThermalPrinterService implements ThermalPrinterService<ThermalPrinterDevice> {
  @override
  Future<List<ThermalPrinterDevice>?> getPrinters() async {
    return [];
  }

  @override
  Future<bool> print(ThermalPrinterDevice printer, Map<String, dynamic> data) async {
    return true;
  }
}
