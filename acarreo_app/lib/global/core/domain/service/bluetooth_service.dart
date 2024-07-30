abstract class BluetoothService {
  Future<bool> get isOnBluetooth;
  void goToSettingBLE();

  Future<bool> checkPermission();
}
