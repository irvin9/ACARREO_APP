import 'dart:async';

import 'package:acarreo_app/global/core/acarreo_core_module.dart'
    hide BluetoothService;
import 'package:acarreo_app/global/core/domain/models/thermal_printer_device.dart';
import 'package:acarreo_app/global/core/domain/service/bluetooth_service.dart';
import 'package:acarreo_app/global/core/domain/service/thermal_printer_service.dart';
// import 'package:acarreo_app/global/core/utils/image_utils.dart';
import 'package:acarreo_app/global/core/utils/logger/logger.dart';
// import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
// import 'package:flutter/services.dart';
// import 'package:image/image.dart';
import 'package:zebrautility/ZebraPrinter.dart';
import 'package:zebrautility/zebrautility.dart';
// import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ZebraPrinterDevice {
  final String label;
  final String address;
  final bool status;

  ZebraPrinterDevice(
      {required this.label, required this.address, required this.status});
}

class GenericThermalPrinterService implements ThermalPrinterService {
  // late final Generator _generator;

  final BluetoothService btnService;

  late final ZebraPrinter zebraPrinter;

  final List<ZebraPrinterDevice> zebraPrinters = [];

  final _printerDetectorStreamController =
      StreamController<List<ZebraPrinterDevice>>.broadcast();

  final _statusPrinterController = StreamController<bool>.broadcast();

  GenericThermalPrinterService({required this.btnService}) {
    _config();
  }

  void _config() async {
    // CapabilityProfile profile = await CapabilityProfile.load();
    // _generator = Generator(PaperSize.mm58, profile);
    zebraPrinter = await Zebrautility.getPrinterInstance(
        onPrinterFound: (label, address, status) {
      if (zebraPrinters.isNotEmpty) {
        zebraPrinters.clear();
      }
      zebraPrinters.add(
          ZebraPrinterDevice(label: label, address: address, status: status));
    }, onPrinterDiscoveryDone: () {
      _printerDetectorStreamController.add(zebraPrinters);
    }, onChangePrinterStatus: (status, code) {
      if (status == 'Connected') {
        _statusPrinterController.add(true);
      } else {
        _statusPrinterController.add(false);
      }
    });
  }

  Future<List<ZebraPrinterDevice>> whenDetectPrinter(
      Stream<List<ZebraPrinterDevice>> source) {
    return source.first;
  }

  Future<bool> waitStautsPrinter(Stream<bool> source, bool status) {
    return source.skipWhile((element) => element != status).first;
  }

  @override
  Future<List<ThermalPrinterDevice>?> getPrinters() async {
    try {
      final isBluetoothOn = await btnService.isOnBluetooth;
      if (!isBluetoothOn) throw Exception('Bluetooth don\'t available.');
      await zebraPrinter.discoveryPrinters();
      final printers =
          await whenDetectPrinter(_printerDetectorStreamController.stream);

      return printers
          .map(
              (p) => ThermalPrinterDevice(name: p.label, identifier: p.address))
          .toList();
    } catch (e, s) {
      Log.error('Exception on -> ${runtimeType.toString()}',
          error: e, stackTrace: s);
      return null;
    }
  }

  // Future<Uint8List> _appendMainLogo() async {
  //   return await getImageBuffer('assets/logo/logo-icon.png');
  // }

  List<String> appendBody(Map<String, dynamic> data) {
    String typeLocation =
        FormValues.typeRegisters["${data['typeLocation']}"] ?? '';

    return [
      "Desarrolladora: ${data['enterpriseName']}",
      "Proyecto: ${data['projectName']}",
      "Fecha:  ${data['date']}",
      "Tipo de viaje: $typeLocation",
      "Ubicación: ${data['location']}",
      "Material: ${data['material']}",
      "Placas:  ${data['plates']}",
      "M3: ${data['capacity']} m3",
      "Nota: ${data['description']}"
    ];
  }

  @override
  Future<bool> disconnect() async {
    try {
      zebraPrinter.disconnect();
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> print(
      ThermalPrinterDevice printer, Map<String, dynamic> data) async {
    try {
      final macAddress = printer.identifier;
      zebraPrinter.connectToPrinter(macAddress);
      final printerConnected =
          await waitStautsPrinter(_statusPrinterController.stream, true)
              .timeout(const Duration(seconds: 10));
      if (!printerConnected) {
        return false;
      }
      final body = appendBody(data);
      for (String line in body) {
        zebraPrinter.print('$line\r');
      }
      zebraPrinter.print('\r\n\t');
      return true;
    } catch (e, s) {
      Log.error(
        'Exception on -> ${runtimeType.toString()}',
        error: e,
        stackTrace: s,
      );
      return false;
    }
  }
}
