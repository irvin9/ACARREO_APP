import 'package:flutter_blue/flutter_blue.dart' hide BluetoothService;
import 'package:open_settings/open_settings.dart';

import '../../domain/service/bluetooth_service.dart';

class FlutterBlueService implements BluetoothService {
  final FlutterBlue flutterBlue = FlutterBlue.instance;

  @override
  void goToSettingBLE() {
    OpenSettings.openBluetoothSetting();
  }

  @override
  Future<bool> get isOnBluetooth => flutterBlue.isOn;
}
