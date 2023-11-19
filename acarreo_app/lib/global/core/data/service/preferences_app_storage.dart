import 'package:acarreo_app/global/core/acarreo_core_module.dart';

class AppPreferencesStorage {
  final LocalStorageService localStorage;

  AppPreferencesStorage({required this.localStorage}) {
    localStorage.init(StorageLocalNames.appPreferences);
  }

  saveDataScreen(String nameScreen, Map<String, dynamic> data) {
    localStorage.saveBykey(nameScreen, data);
  }

  getDataScreen(String nameScreen) {
    return localStorage.getByKey(nameScreen);
  }

  removeDataScreen(String nameScreen) {
    localStorage.deleteItem(nameScreen);
  }
}
