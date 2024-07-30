import 'package:acarreo_app/global/core/utils/logger/logger.dart';
import 'package:flutter_blue/flutter_blue.dart' hide BluetoothService;
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/service/bluetooth_service.dart';

class FlutterBlueService implements BluetoothService {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void goToSettingBLE() {
    OpenSettings.openBluetoothSetting();
  }

  @override
  Future<bool> get isOnBluetooth => flutterBlue.isOn;

  @override
  Future<bool> checkPermission() async {
    try {
      bool statusPermission = false;
      final blueScan = await Permission.bluetoothScan.isGranted;

      if (!blueScan) {
        await Permission.bluetoothScan.request();
      }

      final blueConnect = await Permission.bluetoothConnect.isGranted;

      if (!blueConnect) {
        await Permission.bluetoothConnect.request();
      }
      statusPermission = await Permission.bluetoothConnect.isGranted &&
          await Permission.bluetoothScan.isGranted;
      return statusPermission;
    } catch (e, s) {
      Log.error('$runtimeType', error: e, stackTrace: s);
      return false;
    }
  }
}
