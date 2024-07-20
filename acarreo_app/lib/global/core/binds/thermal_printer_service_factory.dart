import 'package:acarreo_app/global/core/acarreo_core_module.dart'
    hide BluetoothService;
import 'package:acarreo_app/global/core/data/enum/thermal_printer_type.dart';
import 'package:acarreo_app/global/core/data/service/zebra_printer_service.dart';
import 'package:acarreo_app/global/core/domain/service/bluetooth_service.dart';
import 'package:acarreo_app/global/core/domain/service/thermal_printer_service.dart';

class ThermalPrinterServiceFactory {
  static ThermalPrinterService createService(ThermalPrinterType type) {
    final bluetoothService = Modular.get<BluetoothService>();
    switch (type) {
      case ThermalPrinterType.starxpand:
        return StartxpandThermalPrinterService(btnService: bluetoothService);
      case ThermalPrinterType.zebra:
        return ZebraPrinterService(btnService: bluetoothService);
      default:
        throw Exception('Unsupported printer type');
    }
  }
}
